# GitHub Upload Guide

## 1. Create the repository

Go to GitHub and sign in.

Choose:

**New repository**

Suggested repository name:

```text
ecommerce-sales-analysis
```

Suggested description:

```text
PostgreSQL e-commerce sales analysis project with 35 solved SQL questions covering joins, CTEs, aggregations, and window functions.
```

Set the repository to **Public** if you want recruiters to view it.

Do not add a second README if you are uploading the README from this project.

## 2. Create the project folder

Use this structure:

```text
ecommerce-sales-analysis/
├── sql/
│   └── ecommerce_sales_analysis_35_questions.sql
├── linkedin/
│   └── linkedin_post.md
├── docs/
│   └── github_upload_guide.md
├── README.md
└── .gitignore
```

## 3. Upload files through GitHub website

Open your repository.

Choose:

**Add file → Upload files**

Upload all project files/folders.

Then click:

**Commit changes**

## 4. Recommended commit message

```text
Add complete PostgreSQL e-commerce sales analysis project
```

## 5. Git command method

If Git is installed, open Terminal inside the project folder:

```bash
git init
git add .
git commit -m "Add complete PostgreSQL e-commerce sales analysis project"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/ecommerce-sales-analysis.git
git push -u origin main
```

Replace `YOUR_USERNAME` with your GitHub username.

## 6. Check your repository

After pushing, confirm that these are visible:

- README.md
- sql/ecommerce_sales_analysis_35_questions.sql
- linkedin/linkedin_post.md
- docs/github_upload_guide.md

## 7. LinkedIn

After the GitHub repository is public:

1. Open LinkedIn.
2. Create a new post.
3. Copy the content from `linkedin/linkedin_post.md`.
4. Add your GitHub repository link.
5. Add a project screenshot if available.
6. Publish the post.

## 8. Portfolio tip

Keep the repository clean and easy to understand. A recruiter should be able to open the README, understand the project, and find the SQL file without searching through unrelated files.
