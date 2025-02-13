import { writeFile } from "fs/promises";
import { dirname, join } from "path";
import { fileURLToPath } from "url";

const HEADERS = {
    Authorization: `Bearer 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`,
    "Content-Type": "application/json",
    "Notion-Version": "2022-06-28",
};

const respones = await fetch(
    "https://api.notion.com/v1/blocks/e65a0d37-6866-44d5-829e-726aaa848e0d/children",
    {
        headers: HEADERS,
    },
);

const data = await respones.json();

const projects_data = data.results;

const projects = [];

for (const project of projects_data) {
    const project_res = await fetch(
        `https://api.notion.com/v1/blocks/${project.id}`,
        { headers: HEADERS },
    );
    const project_data = await project_res.json();

    const project_title = project_data.heading_2.rich_text[0].plain_text;

    const tasks_res = await fetch(
        `https://api.notion.com/v1/blocks/${project.id}/children`,
        { headers: HEADERS },
    );
    const tasks_data = await tasks_res.json();
    const tasks = [];
    for (const task of tasks_data.results) {
        const task_res = await fetch(
            `https://api.notion.com/v1/blocks/${task.id}`,
            { headers: HEADERS },
        );
        const task_data = await task_res.json();

        tasks.push(task_data.bulleted_list_item.rich_text.map(text => text.plain_text).join(""));
    }
    projects.push({
        title: project_title,
        tasks,
    });
}

const __dirname = dirname(fileURLToPath(import.meta.url))

await writeFile(
    join(__dirname, "data.json"),
    JSON.stringify({ projects }),
);
