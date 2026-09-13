# Contracts — die Inter-Service-Source-of-Truth

> Die Repos sind entkoppelt; diese Contracts sind das Einzige, was sie verbindet. Wenn das
> Verhalten eines Repos an einer Grenze nicht hier (und, wo möglich, in `contracts/` als
> maschinenlesbare Datei) festgehalten ist, existiert es offiziell nicht. Hier ändern = überall ändern.

## Wie man das liest

- Ein Abschnitt pro **veröffentlichter Schnittstelle** (eine HTTP-API, ein Message-/Event-Schema, eine CLI,
  die ein anderes Repo aufruft, ein gemeinsames Dateiformat).
- Jeder benennt seinen **Provider** (das Repo, das ihn besitzt/bedient) und seine **Konsumenten** (Repos,
  die von ihm abhängen — müssen zu den `consumes:`-Kanten in `repos.yaml` passen).
- Die maschinenlesbare Form (OpenAPI / JSON Schema) lebt in `contracts/`; diese Datei ist
  die menschenlesbare Zusammenfassung und der Ort, um festzuhalten, *warum* der Contract so geformt ist.

## Änderungsprotokoll (nicht verhandelbar)

1. Eine Contract-Änderung ist eine **Entscheidung auf Opus-Ebene** — niemals mitten in der Implementierung improvisieren.
2. Die maschinenlesbare Datei in `contracts/` **und** diese Zusammenfassung aktualisieren.
3. **Jeden** unten gelisteten Konsumenten aktualisieren, in der vereinbarten Landing-Reihenfolge (Provider zuerst
   bei additiven Änderungen; Konsumenten zuerst, wenn ein Feld entfernt wird, das sie lesen).
4. `./workspace.sh contracts` dann `./workspace.sh check` ausführen — beide müssen grün sein.

---

## Contract: <name>

- **Provider:** repos/<name>
- **Konsumenten:** repos/<a>, repos/<b>
- **Maschinenlesbar:** `contracts/<name>.openapi.yaml`
- **Transport:** *(HTTP / Queue / Datei / CLI)*

### Oberfläche
*(Endpunkte / Messages / Felder. Knapp halten — die maschinenlesbare Datei ist maßgeblich
für exakte Formen; das ist die „was es bedeutet"-Schicht.)*

### Invarianten & Stolperfallen
*(Versionierungs-Policy, Abwärtskompatibilitäts-Regeln, Felder, die nie ihre Bedeutung ändern dürfen, usw.)*
