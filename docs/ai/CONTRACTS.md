# Contracts — the inter-service source of truth

> The repos are decoupled; these contracts are the only thing connecting them. If a repo's
> behavior at a boundary isn't written here (and, where possible, in `contracts/` as a
> machine-readable file), it does not officially exist. Change here = change everywhere.

## How to read this

- One section per **published interface** (an HTTP API, a message/event schema, a CLI
  another repo calls, a shared file format).
- Each names its **provider** (the repo that owns/serves it) and its **consumers** (repos
  that depend on it — must match the `consumes:` edges in `repos.yaml`).
- The machine-readable form (OpenAPI / JSON Schema) lives in `contracts/`; this file is
  the human-readable summary and the place to record *why* the contract is shaped this way.

## Change protocol (non-negotiable)

1. A contract change is an **Opus-level decision** — never improvise one mid-implementation.
2. Update the machine-readable file in `contracts/` **and** this summary.
3. Update **every** consumer listed below, in the agreed landing order (provider first
   for additive changes; consumers first when removing a field they read).
4. Run `./workspace.sh contracts` then `./workspace.sh check` — both must be green.

---

## Contract: <name>

- **Provider:** repos/<name>
- **Consumers:** repos/<a>, repos/<b>
- **Machine-readable:** `contracts/<name>.openapi.yaml`
- **Transport:** *(HTTP / queue / file / CLI)*

### Surface
*(Endpoints / messages / fields. Keep it tight — the machine-readable file is authoritative
for exact shapes; this is the "what it means" layer.)*

### Invariants & gotchas
*(Versioning policy, backward-compat rules, fields that must never change meaning, etc.)*
