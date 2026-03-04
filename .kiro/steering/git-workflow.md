---
inclusion: auto
description: Enforces branch-based git workflow with auto-push and manual merges for the AOL Underground proggies archive.
---

# Git Workflow — AOL Underground Proggies Archive

## BRANCH RULES (MANDATORY)

1. **NEVER commit directly to `main`.** All work happens on feature/fix branches.
2. Before making any code changes, check the current branch with `git branch --show-current`.
   - If on `main`, create and switch to a new branch FIRST: `git checkout -b <branch-name>`
   - Branch naming: `feat/<topic>`, `fix/<topic>`, `docs/<topic>`, `refactor/<topic>`, `chore/<topic>`
3. Commit early and often on the feature branch.
4. **NEVER merge to main unless the user explicitly says to.** No automatic merges.
5. When the user says to merge:
   ```bash
   git checkout main
   git merge --no-ff <branch-name> -m "Merge <branch-name>: <short description>"
   git push
   git branch -d <branch-name>
   ```
6. The `--no-ff` flag is required — it preserves branch history in the merge commit.
7. **ALWAYS pass `-m "message"` to `git merge`** — never let git open an interactive editor.
8. After merging, delete the branch locally. If pushed to remote, delete there too: `git push origin --delete <branch-name>`

## AUTO-PUSH (via post-commit hook)

A git post-commit hook automatically pushes the current branch to remote after every local commit. No manual `git push` needed.

To install/reinstall the hook:
```bash
cp .github/hooks/post-commit .git/hooks/post-commit
chmod +x .git/hooks/post-commit
```

## COMMIT MESSAGE FORMAT

```
<type>: <short description>
```

Types: `feat`, `fix`, `docs`, `refactor`, `chore`

## LARGE FILE COMMITS

Use the included helper for bulk zip commits to avoid git errors:
```bash
gcommitfile.sh <filename>
```

## CI EXCEPTION

GitHub Actions bot commits (e.g., auto-updating proggie-list-sorted.txt) are exempt from branch rules. These commits go directly to main via the workflow.

## DOCUMENTATION RULES

- New scripts/tools must have usage documented in the nearest README
- Modified scripts — update README if usage/behavior changed
- New folders — create a README.md explaining contents
