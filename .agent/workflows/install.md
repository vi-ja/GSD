---
description: Install DevFlow into the current project from GitHub
---

# /install Workflow

<objective>
Install DevFlow for Antigravity into the current project from GitHub.
</objective>

<process>

## 1. Check for Existing Installation

Look for DevFlow marker directories:

**PowerShell:**
```powershell
$alreadyInstalled = (Test-Path ".agents") -or (Test-Path ".agent") -or (Test-Path ".devflow")
if ($alreadyInstalled) {
    Write-Output "DevFlow files detected in this project."
}
```

**Bash:**
```bash
if [ -d ".agents" ] || [ -d ".agent" ] || [ -d ".devflow" ]; then
    echo "DevFlow files detected in this project."
fi
```

**If already installed:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 DevFlow ► ALREADY INSTALLED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DevFlow files already exist in this project.

───────────────────────────────────────────────────────

A) Reinstall — Overwrite with latest version
B) Cancel — Keep current installation

If you want to update instead: /update

───────────────────────────────────────────────────────
```

If user chooses Cancel, exit.
If user chooses Reinstall, continue to Step 2.

---

## 2. Clone from GitHub

```bash
git clone --depth 1 https://github.com/toonight/devflow-for-antigravity.git .devflow-install-temp
```

---

## 3. Copy Files

**PowerShell:**
```powershell
# Core directories
Copy-Item -Recurse ".devflow-install-temp\.agent" ".\"
Copy-Item -Recurse ".devflow-install-temp\.agents" ".\"
Copy-Item -Recurse ".devflow-install-temp\.gemini" ".\"
Copy-Item -Recurse ".devflow-install-temp\.devflow" ".\"
Copy-Item -Recurse ".devflow-install-temp\adapters" ".\"
Copy-Item -Recurse ".devflow-install-temp\docs" ".\"
Copy-Item -Recurse ".devflow-install-temp\scripts" ".\"

# Root files
Copy-Item -Force ".devflow-install-temp\PROJECT_RULES.md" ".\"
Copy-Item -Force ".devflow-install-temp\DevFlow-STYLE.md" ".\"
Copy-Item -Force ".devflow-install-temp\model_capabilities.yaml" ".\"
```

**Bash:**
```bash
# Core directories
cp -r .devflow-install-temp/.agent ./
cp -r .devflow-install-temp/.agents ./
cp -r .devflow-install-temp/.gemini ./
cp -r .devflow-install-temp/.devflow ./
cp -r .devflow-install-temp/adapters ./
cp -r .devflow-install-temp/docs ./
cp -r .devflow-install-temp/scripts ./

# Root files
cp .devflow-install-temp/PROJECT_RULES.md ./
cp .devflow-install-temp/DevFlow-STYLE.md ./
cp .devflow-install-temp/model_capabilities.yaml ./
```

---

## 4. Cleanup

**PowerShell:**
```powershell
Remove-Item -Recurse -Force ".devflow-install-temp"
```

**Bash:**
```bash
rm -rf .devflow-install-temp
```

---

## 5. Add to .gitignore (Optional)

Check if `.devflow/STATE.md` and other session files should be gitignored:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 DevFlow ► ADD TO .gitignore?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Recommended .gitignore additions for session-specific files:

.devflow/STATE.md
.devflow/JOURNAL.md
.devflow/TODO.md

───────────────────────────────────────────────────────

A) Yes — Add recommended entries
B) No — Skip

───────────────────────────────────────────────────────
```

---

## 6. Confirm Installation

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 DevFlow ► INSTALLED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DevFlow for Antigravity has been installed.

Files installed:
• .agent/        (workflows)
• .agents/       (subagents + skills — Agent Skills standard)
• .gemini/       (Gemini integration)
• .devflow/          (project state templates)
• adapters/      (model-specific enhancements)
• docs/          (operational documentation)
• scripts/       (utility scripts)
• PROJECT_RULES.md
• DevFlow-STYLE.md
• model_capabilities.yaml

───────────────────────────────────────────────────────

Next step:

/new-project — Initialize your project with DevFlow

───────────────────────────────────────────────────────
```

</process>

<notes>
- This workflow is designed to work from a clean project (no prior DevFlow installation)
- It copies ALL necessary files, unlike manual installation which may miss some
- For updates to an existing installation, use /update instead
- The /new-project command should be run after installation to set up SPEC.md
</notes>

