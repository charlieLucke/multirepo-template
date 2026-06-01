# System Map

> The big picture: every service, how they depend on each other, and how data flows
> end-to-end. Read this before touching any repo. Keep it current — `repos.yaml` holds
> the same graph as data; this file explains it in prose.

## What this system does

*(One paragraph: what is the system as a whole, who is it for, what problem does it solve?
Not any single service — the whole.)*

## Services

| Service (`repos/<name>`) | Role | Consumes | Exposes | Port |
|--------------------------|------|----------|---------|------|
| *(name)* | *(one line)* | *(services it calls)* | *(contract file)* | *(port)* |

## Dependency graph

*(Who calls whom. Arrows point from consumer → provider. Keep in sync with the
`consumes:` edges in `repos.yaml`.)*

```
(consumer) ──▶ (provider)
```

## End-to-end data flow

*(Follow the main use case across service boundaries, from the outside in. Name the
contract crossed at each hop.)*

1. ...
2. ...

## Boundaries & invariants

*(What must stay true across the whole system: shared identifiers, ordering guarantees,
who is allowed to write what. The rules a single repo can't enforce alone.)*

## Deployment topology

*(Where each service runs, how they reach each other in prod vs. local, shared infra
like databases or queues.)*
