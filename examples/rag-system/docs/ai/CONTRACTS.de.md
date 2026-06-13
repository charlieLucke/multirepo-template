# Contracts — rag-system (AUSGEFÜLLTES BEISPIEL)

> Die zwei realen Kopplungsflächen in diesem System: titans HTTP-API und brain-mcps MCP-
> Tools. Plus ein impliziter Contract — das Vault-Notiz-Format — der drei Repos zusammenbindet.

---

## Contract: titan HTTP-API

- **Provider:** repos/titan
- **Konsumenten:** repos/brain-mcp (Suche + Ingest), repos/brain-dashboard (nur `/health`)
- **Maschinenlesbar:** `contracts/titan.openapi.yaml`
- **Transport:** HTTP, `127.0.0.1:8765` (nur lokal)

### Oberfläche
- `GET /health` — BGE-M3 geladen? Qdrant erreichbar? VRAM-Nutzung, Collection-Name, ColBERT-Dim.
- `POST /search` — hybride Suche `{query, domain?, top_k}` → gerankte Chunks.
- `POST /ingest/file` — eine Datei (neu) indexieren.
- `GET /domains` — Domains mit Chunk-Anzahl.
- `GET /notes` — indexierte Notizen nach Datei gruppiert.
- `POST /find_related` — semantisch verwandte Dokumente.
- `DELETE /chunks` — die Chunks einer Datei entfernen.

### Invarianten & Stolperfallen
- titan bindet **nur 127.0.0.1** — Single-User, kein Auth/TLS auf dieser Ebene by design.
- Re-Ingest ist **upsert-before-delete** (neue `run_id`); Konsumenten dürfen kein atomares
  Swap-Fenster annehmen.
- `domain` ist ein optionaler Filter auf `/search` und der Cache-Invalidierungs-Key beim Ingest.

---

## Contract: brain-mcp MCP-Tools

- **Provider:** repos/brain-mcp
- **Konsumenten:** Claude (über den Custom Connector via Tailscale Funnel)
- **Maschinenlesbar:** `contracts/brain-mcp.tools.json`
- **Transport:** MCP über HTTP, `:9100`, GitHub-OAuth-gegatet (Allowlist `charlieLucke`)

### Oberfläche
Sechs Tools: `query_knowledge`, `ingest_note`, `list_domains`, `find_related`, `list_notes`,
`delete_note`. Jedes mappt auf einen oder mehrere titan-HTTP-Calls.

### Invarianten & Stolperfallen
- Query-Zerlegung wird auf dem MCP-Pfad **nicht** genutzt (Claude zerlegt selbst).
- Tool-Ergebnisse müssen für den Connector stabil bleiben; ein Tool umzubenennen bricht Claudes Calls.
- „Titan unreachable" aus einem Tool bedeutet, die titan→Qdrant-Kette darunter ist unten, kein MCP-Bug.

---

## Contract: Vault-Notiz-Format (implizit)

- **Provider/Writer:** repos/obsidian-inbox-watcher (und der Mensch, der Notizen editiert)
- **Konsumenten:** repos/brain-mcp (Watcher → titan `/ingest/file`), repos/titan (Domain-Filter)
- **Maschinenlesbar:** keine — durch Konvention erzwungen, hier dokumentiert.

### Oberfläche
Eine Markdown-Notiz mit YAML-Frontmatter, das ein `domain:`-Feld enthält (`lernen` / `projekte` /
`system` / `business`). `indexed: false` meldet eine Notiz ab (und entfernt ihre Chunks).

### Invarianten & Stolperfallen
- **Kein `domain:` → nicht indexiert.** Das ist die wichtigste gemeinsame Invariante.
- Die erlaubten Domain-Werte zu ändern, berührt alle drei Repos → eine Änderung auf Workspace-Ebene.
