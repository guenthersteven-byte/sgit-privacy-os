# sgiT Template System - Versionshistorie

**Aktuelle Version:** 1.2  
**Letztes Update:** 2025-12-08  
**Maintained by:** deStevie / sgiT Solution Engineering

---

## Semantic Versioning

Wir nutzen [SemVer](https://semver.org/):

```
MAJOR.MINOR.PATCH

MAJOR = Breaking Changes (inkompatibel mit vorherigen Templates)
MINOR = Neue Features (rückwärtskompatibel)
PATCH = Bugfixes, kleine Verbesserungen
```

---

## Changelog

### v1.2 - 2025-12-08 (Aktuell)

**Typ:** Major Feature Update

**Neue Features:**
- ✅ **Archiv-Strategie für Status-Reports**
  - Bei >500 Zeilen: Separates `_ARCHIVE.md` erstellen
  - Quick-Start Section IMMER ganz oben
  - Grund: AI-Chat-Stabilität, Token-Limit schonen

- ✅ **VERSION.md eingeführt**
  - Zentrale Versionshistorie
  - Semantic Versioning Standard
  - Upgrade-Guide dokumentiert

- ✅ **Docker Best Practices Section** (NEU!)
  - docker-compose.yml Beispiele
  - Befehle Cheat-Sheet
  - PHP Dockerfile Template
  - Wichtige Regeln

- ✅ **AI/Ollama Best Practices Section** (NEU!)
  - Model-Auswahl Entscheidungsbaum
  - API-Aufruf PHP Beispiel
  - Performance-Tipps
  - Empfohlenes Model: gemma2:2b

- ✅ **Erweiterte Backup-Strategie** (NEU!)
  - 3-2-1 Backup Regel
  - Lokale + Cloud-Backup Scripts
  - Backup-Schedule Tabelle
  - Restore-Prozedur

- ✅ **Environment Variables Section** (NEU!)
  - Standard .env Struktur
  - PHP loadEnv() Funktion
  - .env.example Template
  - .gitignore Regeln

- ✅ **Quick Reference Card** (NEU!)
  - 1-Seiter zum Ausdrucken
  - Alle wichtigen Befehle
  - Docker, Git, Ollama, Backup

**Geänderte Dateien:**
- `VERSION.md` - Erweitert
- `README.md` - Version-Bump, neue Datei dokumentiert
- `sgit_project_template.md` - Komplett überarbeitet (+400 Zeilen)
- `sgit_status_report_template.md` - Archiv-Section
- `sgit_template_usage_guide.md` - Archiv-Workflow
- `sgit_quick_start_guide.md` - Archiv-Tipp
- `sgit_quick_reference_card.md` - NEU erstellt

**Basiert auf Erfahrung aus:**
- sgiT Education Platform (Docker/nginx/PHP-FPM, Ollama gemma2:2b)
- Multi-Session Projektarbeit mit Claude
- 3+ Monate produktiver Docker-Einsatz

---

### v1.1 - 2024-12-01

**Typ:** Feature

**Neue Features:**
- ✅ Bot-Framework Template hinzugefügt
- ✅ Polyglot Programming Guide hinzugefügt
- ✅ Quick Links erweitert (Austrian Economics, Bitcoin)

**Geänderte Dateien:**
- `README.md` - Bot-Framework Sektion
- `sgit_bot_framework_template.md` - NEU
- `sgit_polyglot_programming_guide.md` - NEU

---

### v1.0 - 2024-12-01 (Initial Release)

**Typ:** Initial Release

**Enthaltene Templates:**
- `sgit_project_template.md` - Master-Template
- `sgit_quick_start_guide.md` - Schnellreferenz
- `sgit_status_report_template.md` - Status-Report
- `sgit_template_usage_guide.md` - Anwendungsanleitung
- `README.md` - Übersicht

**Basiert auf:**
- 20 Jahre IT-Erfahrung in jeglichen bereichen Solution Engineer
- sgiT Education Platform Entwicklung
- Österreichische Schule der Ökonomie Prinzipien

---

## Upgrade-Guide

### Von v1.1 auf v1.2

**Empfohlene Schritte:**

1. **Neue VERSION.md kopieren**
   ```bash
   cp VERSION.md ~/sgiT_Templates/
   ```

2. **Status-Report Template aktualisieren**
   - Quick-Start Section an den Anfang verschieben
   - Archiv-Warnung bei >500 Zeilen hinzufügen
   - Archiv-Verweis Section am Ende

3. **Bestehende große Status-Reports aufteilen**
   ```
   Falls [projekt]_status_report.md > 500 Zeilen:
   1. Erstelle [projekt]_ARCHIVE.md
   2. Verschiebe: Geschlossene Bugs, alte Sessions, Versions-Historie
   3. Behalte: Offene TODOs, aktuelle Bugs, aktuelle Session
   ```

---

## Roadmap

### Geplant für v1.3
- [ ] CI/CD Integration Templates
- [ ] Docker-Compose Templates
- [ ] Automatisches Archiv-Script

### Langfristig (v2.0)
- [ ] Template-Generator CLI Tool
- [ ] GitHub Template Repository
- [ ] Interaktive Template-Auswahl

---

*Maintained by deStevie / sgiT Solution Engineering*
