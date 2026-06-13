# Beispiel: rag-system

Eine **ausgefüllte** Instanz dieses Templates, modelliert nach charlies echtem lokalem RAG-Stack. Sie
zeigt, wie die Workspace-Dateien aussehen, sobald ein System tatsächlich existiert — nutze sie als
Referenz beim Ausfüllen deines eigenen.

Die vier Services (bereits echte Repos unter `~/projects`):

| Repo | Rolle | Port |
|------|------|------|
| `titan` | RAG-Engine (Ingest + hybride Suche über Qdrant) | 8765 |
| `brain-mcp` | MCP-Server + Vault-Watcher (Brücke zu Claude) | 9100 |
| `brain-dashboard` | Web-Control-Panel (Status/Logs/Start-Stopp) | 9200 |
| `obsidian-inbox-watcher` | Rohdokumente → Gemini → Vault-Notiz | — |

Was hier zu lesen ist:

- [`repos.yaml`](repos.yaml) — das Manifest, mit echten `consumes`/`exposes`/`port`-Kanten.
- [`docs/ai/SYSTEM.md`](docs/ai/SYSTEM.md) — Abhängigkeitsgraph + End-to-end-Datenfluss.
- [`docs/ai/ROUTING.md`](docs/ai/ROUTING.md) — konkrete „wohin geht diese Änderung"-Tabelle.
- [`docs/ai/CONTRACTS.md`](docs/ai/CONTRACTS.md) — die drei echten Kopplungsflächen.
- [`contracts/`](contracts/) — maschinenlesbare titan-OpenAPI + brain-mcp-Tool-Schema.

Dieses Verzeichnis wird von `init-workspace.sh` bewusst übersprungen, sodass seine echten Namen erhalten
bleiben, wenn du ein neues System aus dem Template initialisierst.
