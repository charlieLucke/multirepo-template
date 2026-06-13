# Routing — wohin gehört eine Änderung?

> Bevor du etwas editierst, das besitzende Repo hier finden. Das ist die wichtigste
> Datei für einen Multi-Repo-Agenten: sie verhindert „Ich habe das Repo editiert, das ich zufällig offen hatte."

## Eigentümerschaft nach Verantwortung

| Wenn die Änderung … betrifft | Gehört sie in Repo … | Notizen |
|-------------------------|---------------------|-------|
| *(Verhaltensbereich)* | *(repos/name)* | *(z. B. „auch Contract X aktualisieren")* |

## Eigentümerschaft nach Datei-/Pfad-Muster

*(Optional, aber mächtig: glob-artige Muster auf Repos abbilden, sodass ein Agent schnell routen kann.)*

| Muster | Repo |
|---------|------|
| *(z. B. alles über HTTP-Endpunkte)* | *(repos/api)* |

## Repo-übergreifende Änderungen

Eine Änderung überspannt Repos, wenn sie einen **Contract** berührt oder ein Verhalten, dessen Effekt
über eine Grenze hinweg sichtbar ist. Wenn das passiert:

1. **Nicht** mit dem Editieren anfangen. Einen Workspace-Plan in `docs/ai/plans/` schreiben/bestätigen.
2. Der Plan listet die Per-Repo-Teiländerungen und die **Landing-Reihenfolge** (Provider zuerst).
3. Jeden Contract in `contracts/` + `docs/ai/CONTRACTS.md` als Teil der Änderung aktualisieren.
4. Mit `./workspace.sh contracts` und `./workspace.sh check` verifizieren.

## Schneller Entscheidungsbaum

- Verhaltensänderung nur innerhalb eines Repos sichtbar? → dieses Repo editieren, seiner `CLAUDE.md` folgen.
- Ändert einen veröffentlichten Endpunkt / eine Message-Form? → Contract-Änderung → **erst Opus-Plan**.
- Fügt einen neuen Service hinzu oder verschiebt Verantwortung zwischen Repos? → **Opus-Entscheidung** in
  Workspace-`DECISIONS.md`, dann `repos.yaml` + `SYSTEM.md` aktualisieren.
- Berührt `shared/`? → es propagiert zu jedem Repo → als systemweite Änderung behandeln.
