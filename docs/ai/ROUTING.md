# Routing — where does a change belong?

> Before editing anything, find the owning repo here. This is the single most important
> file for a multi-repo agent: it prevents "I edited the repo I happened to have open."

## Ownership by responsibility

| If the change is about… | It belongs in repo… | Notes |
|-------------------------|---------------------|-------|
| *(area of behavior)* | *(repos/name)* | *(e.g. "also update contract X")* |

## Ownership by file/path pattern

*(Optional but powerful: map glob-ish patterns to repos so an agent can route fast.)*

| Pattern | Repo |
|---------|------|
| *(e.g. anything about HTTP endpoints)* | *(repos/api)* |

## Cross-repo changes

A change spans repos when it touches a **contract** or a behavior whose effect is visible
across a boundary. When that happens:

1. Do **not** start editing. Write/confirm a workspace plan in `docs/ai/plans/`.
2. The plan lists the per-repo sub-changes and the **landing order** (providers first).
3. Update each contract in `contracts/` + `docs/ai/CONTRACTS.md` as part of the change.
4. Verify with `./workspace.sh contracts` and `./workspace.sh check`.

## Quick decision tree

- Behavior change visible only inside one repo? → edit that repo, follow its `CLAUDE.md`.
- Changes a published endpoint / message shape? → contract change → **Opus plan first**.
- Adds a new service or moves responsibility between repos? → **Opus decision** in
  workspace `DECISIONS.md`, then update `repos.yaml` + `SYSTEM.md`.
- Touches `shared/`? → it propagates to every repo → treat as a system-wide change.
