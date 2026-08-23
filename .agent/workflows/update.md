---
description: Update DevFlow to the latest version from GitHub
---

# /update Workflow

<objective>
Update DevFlow for Antigravity to the latest version from GitHub.
</objective>

<process>

## 1. Check Current Version

**PowerShell:**
```powershell
if (Test-Path "CHANGELOG.md") {
    $version = Select-String -Path "CHANGELOG.md" -Pattern "## \[(\d+\.\d+\.\d+)\]" | 
        Select-Object -First 1
    Write-Output "Current version: $($version.Matches.Groups[1].Value)"
}
```

**Bash:**
```bash
if [ -f "CHANGELOG.md" ]; then
    version=$(grep -oP '## \[\K[0-9]+\.[0-9]+\.[0-9]+' CHANGELOG.md | head -1)
    echo "Current version: $version"
fi
```

---

## 2. Fetch Latest from GitHub

```bash
# Clone latest to temp directory
git clone --depth 1 https://github.com/toonight/devflow-for-antigravity.git .devflow-update-temp
```

---

## 3. Compare Versions

**PowerShell:**
```powershell
$remoteVersion = Select-String -Path ".devflow-update-temp/CHANGELOG.md" -Pattern "## \[(\d+\.\d+\.\d+)\]" | 
    Select-Object -First 1

Write-Output "Remote version: $($remoteVersion.Matches.Groups[1].Value)"
```

**Bash:**
```bash
remote_version=$(grep -oP '## \[\K[0-9]+\.[0-9]+\.[0-9]+' .devflow-update-temp/CHANGELOG.md | head -1)
echo "Remote version: $remote_version"
```

**If same version:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 DevFlow ► ALREADY UP TO DATE ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Version: {version}

No updates available.

───────────────────────────────────────────────────────
```
Exit after cleanup.

---

## 4. Show Changes

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 DevFlow ► UPDATE AVAILABLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current: {current-version}
Latest:  {remote-version}

Changes:
{Extract from CHANGELOG.md}

───────────────────────────────────────────────────────

Update now?
A) Yes — Apply updates
B) No — Cancel

───────────────────────────────────────────────────────
```

---

## 5. Apply Updates

**If user confirms:**

**PowerShell:**
```powershell
# Backup current
Copy-Item -Recurse ".agent" ".agent.backup"
Copy-Item -Recurse ".agents" ".agents.backup"
Copy-Item -Recurse ".devflow/templates" ".devflow/templates.backup"

# Update workflows (preserve user's .devflow docs)
Copy-Item -Recurse -Force ".devflow-update-temp/.agent/*" ".agent/"

# Update skills (Agent Skills standard)
Copy-Item -Recurse -Force ".devflow-update-temp/.agents/*" ".agents/"

# Update templates only
Copy-Item -Recurse -Force ".devflow-update-temp/.devflow/templates/*" ".devflow/templates/"

# Update root files
Copy-Item -Force ".devflow-update-temp/DevFlow-STYLE.md" "./"
Copy-Item -Force ".devflow-update-temp/CHANGELOG.md" "./"
Copy-Item -Force ".devflow-update-temp/PROJECT_RULES.md" "./"
Copy-Item -Force ".devflow-update-temp/VERSION" "./"
```

**Bash:**
```bash
# Backup current
cp -r .agent .agent.backup
cp -r .agents .agents.backup
cp -r .devflow/templates .devflow/templates.backup

# Update workflows (preserve user's .devflow docs)
cp -r .devflow-update-temp/.agent/* .agent/

# Update skills (Agent Skills standard)
cp -r .devflow-update-temp/.agents/* .agents/

# Update templates only
cp -r .devflow-update-temp/.devflow/templates/* .devflow/templates/

# Update root files
cp .devflow-update-temp/DevFlow-STYLE.md ./
cp .devflow-update-temp/CHANGELOG.md ./
cp .devflow-update-temp/PROJECT_RULES.md ./
cp .devflow-update-temp/VERSION ./
```

---

## 6. Cleanup

**PowerShell:**
```powershell
Remove-Item -Recurse -Force ".devflow-update-temp"
Remove-Item -Recurse -Force ".agent.backup"
Remove-Item -Recurse -Force ".agents.backup"
Remove-Item -Recurse -Force ".devflow/templates.backup"
```

**Bash:**
```bash
rm -rf .devflow-update-temp
rm -rf .agent.backup
rm -rf .agents.backup
rm -rf .devflow/templates.backup
```

---

## 7. Confirm

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 DevFlow ► UPDATED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Updated to version {remote-version}

───────────────────────────────────────────────────────

/whats-new — See what changed

───────────────────────────────────────────────────────
```

</process>

<preserved_files>
These user files are NEVER overwritten:
- .devflow/SPEC.md
- .devflow/ROADMAP.md
- .devflow/STATE.md
- .devflow/ARCHITECTURE.md
- .devflow/STACK.md
- .devflow/DECISIONS.md
- .devflow/JOURNAL.md
- .devflow/TODO.md
- .devflow/phases/*
- .gemini/GEMINI.md
</preserved_files>

