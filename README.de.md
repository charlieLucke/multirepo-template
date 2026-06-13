# SYSTEM_NAME

SYSTEM_DESCRIPTION

<!-- TEMPLATE-USAGE:START (this section is removed by init-workspace.sh) -->
## Ein System aus diesem Template erstellen

Das ist ein **Multi-Repo-Workspace-Template**. Es enthält selbst keinen Anwendungscode —
es ist die Koordinationsschicht („Meta-Repo"), die über einem Satz von Service-Repos sitzt, von denen
jedes aus dem Single-Repo-Template
[python-template](https://github.com/charlieLucke/python-template) erstellt wird.

Es gibt einem System unabhängiger Repos ein gemeinsames Hirn: ein System-Level-`docs/ai/`,
eine Contract-Registry, Repo-übergreifende Pläne/Handoff, DRY-Konventionen und ein Quality-Gate.

Um ein neues System daraus zu starten:

```bash
./init-workspace.sh my-system "A short description of the system"
```

Das ersetzt die `SYSTEM_NAME`- / `SYSTEM_DESCRIPTION`-Platzhalter, initialisiert ein frisches
git-Repo, entfernt diesen Abschnitt und löscht das Skript selbst. Dann:

```bash
./workspace.sh new api   "HTTP API and domain logic"     # ersten Service scaffolden
./workspace.sh new worker "Background job processor"      # einen weiteren scaffolden
./workspace.sh check                                      # systemweites Quality-Gate
```

Ein ausgearbeitetes Beispiel eines ausgefüllten Systems (ein lokaler RAG-Stack) liegt in
[`examples/rag-system/`](examples/rag-system/).
<!-- TEMPLATE-USAGE:END -->

## Was das ist

Ein System wird aus **unabhängigen Service-Repos** gebaut, die nur durch explizite
**Contracts** verbunden sind (HTTP-APIs, Message-Schemas). Jedes Repo ist eigenständig lauffähig und besitzt
seine eigenen Tests, CI und `docs/ai/`. Dieser Workspace ergänzt die Schicht, die kein einzelnes Repo
halten kann:

| Schicht | Lebt in | Besitzt |
|-------|----------|------|
| **System** | dieses Repo | Architektur über Repos hinweg, Contracts, Repo-übergreifende Pläne/Handoff, gemeinsame Konventionen, System-Quality-Gate |
| **Service** | `repos/<name>/` | eine abgegrenzte Verantwortung, eigener Code/Tests/CI und lokales `docs/ai/` |

## Aufbau

```
repos.yaml            Manifest: jeder Service, seine Rolle, Contracts, Abhängigkeitskanten
workspace.sh          clone-all · sync · for-each · check · new · contracts
init-workspace.sh     Einmalig: Platzhalter füllen, git init, Selbstlöschung
docs/ai/              System-Level-Agenten-Hirn (siehe unten)
  SYSTEM.md           Die Karte: alle Services, Abhängigkeitsgraph, End-to-end-Datenfluss
  ROUTING.md          „Welches Repo besitzt was / wo eine Änderung machen"
  CONTRACTS.md        Menschliche Source-of-Truth für Inter-Service-APIs
  DECISIONS.md        Nur Repo-übergreifende ADRs (Per-Repo-Entscheidungen bleiben lokal)
  CURRENT_TASK.md     Das aktive Feature, das Repos überspannt
  HANDOFF.md          System-Handoff: welche Repos bei welchem Commit
  IDEAS.md            Parkplatz
  plans/              Opus-erstellte Pläne, die mehrere Repos koordinieren
contracts/            Maschinenlesbare Contracts (OpenAPI, JSON Schema, …)
shared/               DRY-Konventionsfragmente, in jedes Child-Repo gezogen
repos/                Geklonte Child-Repos (gitignored, jedes ein eigenes git-Repo)
.github/workflows/    Orchestrierende CI: Per-Repo-Check + Contract-Verify + Smoke
examples/rag-system/  Ein vollständig ausgefülltes Beispielsystem
```

## Befehle

```bash
./workspace.sh clone            # jeden Service aus repos.yaml nach repos/ klonen
./workspace.sh sync             # git pull --ff-only für jeden Service
./workspace.sh status           # kurzer git-Status jedes Service
./workspace.sh new <name> <desc># einen neuen Service aus dem Template scaffolden + registrieren
./workspace.sh foreach '<cmd>'  # einen Shell-Befehl in jedem Service-Repo ausführen
./workspace.sh check            # Per-Repo-`make check` + Contract-Verify (das Gate)
./workspace.sh contracts        # prüfen, ob jeder Service noch zu seinem veröffentlichten Contract passt
./workspace.sh lock             # repos.lock schreiben, das jeden Service auf seinen HEAD-Commit pinnt
./workspace.sh graph            # den Abhängigkeitsgraphen aus repos.yaml ausgeben
```

## Arbeiten mit KI-Tools

Zuerst `CLAUDE.md` lesen (gespiegelt als `AGENTS.md` / `GEMINI.md`). Sie definiert die
**Multi-Repo-Betriebsregeln**, die über den eigenen Agenten-Regeln jedes Child-Repos liegen:
Locate-before-editing via `ROUTING.md`, Contracts-are-Law, One-Feature-One-Plan und
das System-Quality-Gate. Child-Repos behalten ihre eigene `CLAUDE.md` für lokale Arbeit.

## Lizenz

Noch offen (TBD)
