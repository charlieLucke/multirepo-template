# System-Entscheidungs-Log

> Architecture Decision Records nur für **Repo-übergreifende** Entscheidungen. Entscheidungen über die
> Interna eines einzelnen Repos gehören in dessen `docs/ai/DECISIONS.md`. Nur anhängen.

## Format

```
## JJJJ-MM-TT: Kurztitel
**Entscheidung:** Was wir entschieden haben
**Begründung:** Warum
**Erwogene Alternativen:** Was wir verworfen haben und warum
**Konsequenzen:** Was das für die Zukunft bedeutet
```

---

## Anfangsentscheidungen (Template-Defaults)

## 2026-XX-XX: Multi-Repo statt Monorepo
**Entscheidung:** Das System ist ein Satz unabhängiger Repos, durch Contracts verbunden, koordiniert von
diesem Workspace-Meta-Repo — kein einzelnes Monorepo.
**Begründung:** Services deployen und versionieren unabhängig; jedes bleibt eigenständig lauffähig und
klein genug, dass ein Agent es im Kontext halten kann; Grenzen werden durch Contracts erzwungen, nicht
durch Konvention.
**Erwogene Alternativen:** Monorepo (einfacheres Repo-übergreifendes Refactoring, aber koppelt Deploys und
verwischt Eigentümerschaft). Git-Submodule (reproduzierbar, aber schmerzhafte UX; Agenten stolpern über Detached
HEAD).
**Konsequenzen:** Repos werden über das `repos.yaml`-Manifest nach `repos/` (gitignored) geklont.
Repo-übergreifende Koordination läuft über Contracts, Workspace-Pläne und `workspace.sh`.

## 2026-XX-XX: Contracts sind die einzige Kopplung
**Entscheidung:** Repos dürfen nur über Schnittstellen voneinander abhängen, die in
`docs/ai/CONTRACTS.md` + `contracts/` festgehalten sind. Kein Hineingreifen in die Interna eines anderen Repos.
**Begründung:** Hält Repos austauschbar und unabhängig testbar; macht Brüche erkennbar
(`workspace.sh contracts`) statt still.
**Konsequenzen:** Jede veröffentlichte Schnittstelle braucht einen Contract-Eintrag; Contract-Änderungen sind
Opus-Ebene und müssen alle Konsumenten aktualisieren.

## 2026-XX-XX: Jeder Service wird aus dem Single-Repo-Template gebaut
**Entscheidung:** Neue Services werden aus `charlieLucke/python-template` via
`./workspace.sh new` gescaffoldet und erben uv + ruff + mypy-strict + pytest + pre-commit + CI und den
`docs/ai/`-Workflow.
**Begründung:** Ein Satz Konventionen und ein Quality-Gate pro Repo; der Workspace ergänzt nur
die Systemschicht obendrauf, statt Per-Repo-Tooling neu zu erfinden.
**Konsequenzen:** Per-Repo-Konventionen leben in `shared/` und werden hereingezogen, nicht von Hand kopiert.
