---
description: Mark current milestone as complete and archive
---

# /complete-milestone Workflow

<objective>
Finalize the current milestone, archive documentation, and prepare for next milestone.
</objective>

<process>

## 1. Verify All Phases Complete

**PowerShell:**
```powershell
# Check ROADMAP.md for incomplete phases
Select-String -Path ".devflow/ROADMAP.md" -Pattern "Status.*Not Started|Status.*In Progress"
```

**Bash:**
```bash
# Check ROADMAP.md for incomplete phases
grep -E "Status.*Not Started|Status.*In Progress" ".devflow/ROADMAP.md"
```

**If incomplete phases found:**
```
⚠️ Cannot complete milestone — {N} phases incomplete

Run /progress to see status.
```

---

## 2. Run Final Verification

Verify all must-haves from ROADMAP.md:
- Run verification commands
- Capture evidence
- Create VERIFICATION.md if not exists

---

## 3. Generate Milestone Summary

Create `.devflow/milestones/{name}-SUMMARY.md`:

```markdown
# Milestone: {name}

## Completed: {date}

## Deliverables
- ✅ {must-have 1}
- ✅ {must-have 2}

## Phases Completed
1. Phase 1: {name} — {date}
2. Phase 2: {name} — {date}
...

## Metrics
- Total commits: {N}
- Files changed: {M}
- Duration: {days}

## Lessons Learned
{Auto-extract from DECISIONS.md and JOURNAL.md}
```

---

## 4. Archive Current State

**PowerShell:**
```powershell
# Create milestone archive
New-Item -ItemType Directory -Force ".devflow/milestones/{name}"

# Move phase-specific files
Move-Item ".devflow/phases/*" ".devflow/milestones/{name}/"

# Archive decisions and journal (prevent monolithic growth across milestones)
if (Test-Path ".devflow/DECISIONS.md") {
    Copy-Item ".devflow/DECISIONS.md" ".devflow/milestones/{name}/DECISIONS.md"
}
if (Test-Path ".devflow/JOURNAL.md") {
    Copy-Item ".devflow/JOURNAL.md" ".devflow/milestones/{name}/JOURNAL.md"
}
```

**Bash:**
```bash
# Create milestone archive
mkdir -p ".devflow/milestones/{name}"

# Move phase-specific files
mv .devflow/phases/* ".devflow/milestones/{name}/"

# Archive decisions and journal (prevent monolithic growth across milestones)
[ -f ".devflow/DECISIONS.md" ] && cp ".devflow/DECISIONS.md" ".devflow/milestones/{name}/DECISIONS.md"
[ -f ".devflow/JOURNAL.md" ] && cp ".devflow/JOURNAL.md" ".devflow/milestones/{name}/JOURNAL.md"
```

---

## 5. Reset for Next Milestone

Clear ROADMAP.md phases section (keep header).
Update STATE.md to show milestone complete.

**Reset DECISIONS.md** — replace contents with a fresh header referencing the archive:

```markdown
# Decisions

> Previous milestone decisions archived in `.devflow/milestones/{name}/DECISIONS.md`

---
```

**Reset JOURNAL.md** — replace contents with a fresh header:

```markdown
# Journal

> Previous milestone journal archived in `.devflow/milestones/{name}/JOURNAL.md`

---
```

---

## 5c. Refresh Architecture

Update `.devflow/ARCHITECTURE.md` to reflect the current state of the codebase after the milestone:

1. **Scan the project** — identify new components, removed modules, changed dependencies
2. **Update the architecture diagram** — reflect structural changes from this milestone
3. **Update STACK.md** — refresh technology and dependency information
4. **Keep it lean** — remove details about components that no longer exist; summarize, don't accumulate

> This prevents ARCHITECTURE.md from becoming stale or bloated across milestones (addresses the issue where architecture only updates via `/map`).

---

## 5d. Update Requirements

If `.devflow/REQUIREMENTS.md` exists, mark completed requirements:

1. Read each requirement's status
2. Cross-reference with milestone deliverables and verification results
3. Mark satisfied requirements as `Complete`
4. Mark deferred items as `Deferred` with reason
5. Archive the requirements snapshot into `.devflow/milestones/{name}/REQUIREMENTS.md`

---

## 6. Commit and Tag

```bash
git add -A
git commit -m "docs: complete milestone {name}"
git tag -a "{name}" -m "Milestone {name} complete"
```

---

## 7. Celebrate

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 DevFlow ► MILESTONE COMPLETE 🎉
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

{name}

Phases: {N} completed
Tag: {name}

───────────────────────────────────────────────────────

▶ NEXT

/new-milestone — Start next milestone
/audit-milestone {name} — Review this milestone

───────────────────────────────────────────────────────
```

</process>

