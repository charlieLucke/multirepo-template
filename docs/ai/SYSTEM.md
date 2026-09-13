# Systemkarte

> Das große Ganze: jeder Service, wie sie voneinander abhängen und wie Daten end-to-end
> fließen. Das lesen, bevor du irgendein Repo anfasst. Aktuell halten — `repos.yaml` hält
> denselben Graphen als Daten; diese Datei erklärt ihn in Prosa.

## Was dieses System macht

*(Ein Absatz: was ist das System als Ganzes, für wen ist es, welches Problem löst es?
Nicht ein einzelner Service — das Ganze.)*

## Services

| Service (`repos/<name>`) | Rolle | Konsumiert | Stellt bereit | Port |
|--------------------------|------|----------|---------|------|
| *(Name)* | *(eine Zeile)* | *(Services, die er aufruft)* | *(Contract-Datei)* | *(Port)* |

## Abhängigkeitsgraph

*(Wer ruft wen auf. Pfeile zeigen von Konsument → Provider. Synchron halten mit den
`consumes:`-Kanten in `repos.yaml`.)*

```
(Konsument) ──▶ (Provider)
```

## End-to-end-Datenfluss

*(Dem Hauptanwendungsfall über Service-Grenzen hinweg folgen, von außen nach innen. Den
bei jedem Hop gekreuzten Contract benennen.)*

1. ...
2. ...

## Grenzen & Invarianten

*(Was über das gesamte System wahr bleiben muss: gemeinsame Identifikatoren, Ordering-Garantien,
wer was schreiben darf. Die Regeln, die ein einzelnes Repo nicht allein erzwingen kann.)*

## Deployment-Topologie

*(Wo jeder Service läuft, wie sie sich in Prod vs. lokal erreichen, gemeinsame Infra
wie Datenbanken oder Queues.)*
