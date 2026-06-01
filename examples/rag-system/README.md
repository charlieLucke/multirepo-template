# Example: rag-system

A **filled-in** instance of this template, modeled on charlie's real local RAG stack. It
shows what the workspace files look like once a system actually exists — use it as a
reference when filling in your own.

The four services (already real repos under `~/projects`):

| Repo | Role | Port |
|------|------|------|
| `titan` | RAG engine (ingest + hybrid search over Qdrant) | 8765 |
| `brain-mcp` | MCP server + vault watcher (bridge to Claude) | 9100 |
| `brain-dashboard` | Web control panel (status/logs/start-stop) | 9200 |
| `obsidian-inbox-watcher` | Raw docs → Gemini → vault note | — |

What to read here:

- [`repos.yaml`](repos.yaml) — the manifest, with real `consumes`/`exposes`/`port` edges.
- [`docs/ai/SYSTEM.md`](docs/ai/SYSTEM.md) — dependency graph + end-to-end data flow.
- [`docs/ai/ROUTING.md`](docs/ai/ROUTING.md) — concrete "where does this change go" table.
- [`docs/ai/CONTRACTS.md`](docs/ai/CONTRACTS.md) — the three real coupling surfaces.
- [`contracts/`](contracts/) — machine-readable titan OpenAPI + brain-mcp tool schema.

This directory is intentionally skipped by `init-workspace.sh`, so its real names survive
when you initialize a new system from the template.
