# sgiT Project Template System - Anwendungsanleitung

**Version:** 1.2  
**Letzte Aktualisierung:** 2025-12-08

## 📦 PAKET-ÜBERSICHT

Du hast jetzt **3 essenzielle Dokumente** für alle zukünftigen Projekte:

### 1️⃣ **sgit_project_template.md**
**Zweck:** Umfassendes Master-Template mit allen Best Practices  
**Umfang:** ~500 Zeilen - Vollständige Referenz  
**Nutze es für:** Nachschlagen, Komplexe Projekte, Team-Onboarding

### 2️⃣ **sgit_quick_start_guide.md**
**Zweck:** Schnellreferenz für tägliche Arbeit  
**Umfang:** ~300 Zeilen - Essentials  
**Nutze es für:** Quick Lookup, Copy-Paste Code, Checklisten

### 3️⃣ **sgit_status_report_template.md**
**Zweck:** Fertiges Status-Report Template zum Kopieren  
**Umfang:** Vollständig ausgefüllte Struktur  
**Nutze es für:** Jedes neue Projekt - einfach ausfüllen

---

## 🚀 SETUP FÜR NEUES PROJEKT

### Option A: Manuell (5 Minuten)

```bash
# 1. Neuen Projekt-Ordner erstellen
mkdir mein_neues_projekt
cd mein_neues_projekt

# 2. Standard-Struktur anlegen
mkdir core modules assets logs database tests docs

# 3. Templates kopieren
cp sgit_project_template.md docs/
cp sgit_quick_start_guide.md docs/
cp sgit_status_report_template.md mein_projekt_status_report.md

# 4. Status-Report anpassen
# → Öffne mein_projekt_status_report.md
# → Ersetze alle [PLATZHALTER] mit echten Werten
# → Speichern

# 5. Git initialisieren
git init
git add .
git commit -m "INIT: Projekt Setup mit sgiT Template"

# 6. Erste Zeile dokumentieren
echo "Projekt gestartet: $(date)" >> mein_projekt_status_report.md
```

### Option B: Mit Script (1 Minute)

Erstelle eine Datei `sgit_new_project.sh`:

```bash
#!/bin/bash

# sgiT New Project Setup Script
# Verwendung: ./sgit_new_project.sh projektname

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: ./sgit_new_project.sh projektname"
    exit 1
fi

echo "🚀 Erstelle neues sgiT Projekt: $PROJECT_NAME"

# Struktur erstellen
mkdir -p "$PROJECT_NAME"/{core,modules,assets/{css,js,images},logs,database,tests,docs}

# Templates kopieren
cp sgit_project_template.md "$PROJECT_NAME/docs/"
cp sgit_quick_start_guide.md "$PROJECT_NAME/docs/"
cp sgit_status_report_template.md "$PROJECT_NAME/${PROJECT_NAME}_status_report.md"

# Status Report initialisieren
cd "$PROJECT_NAME"
sed -i "s/\[PROJEKTNAME\]/$PROJECT_NAME/g" "${PROJECT_NAME}_status_report.md"
echo "Projekt gestartet: $(date)" >> "${PROJECT_NAME}_status_report.md"

# Git initialisieren
git init
git add .
git commit -m "INIT: Projekt Setup mit sgiT Template"

echo "✅ Projekt $PROJECT_NAME erfolgreich erstellt!"
echo "📝 Nächster Schritt: ${PROJECT_NAME}_status_report.md anpassen"
```

**Verwendung:**
```bash
chmod +x sgit_new_project.sh
./sgit_new_project.sh mein_neues_projekt
```

---

## 📋 PROJEKT-START CHECKLISTE

### Phase 1: Initialisierung (Tag 1)

```
□ Projekt-Ordner mit Struktur erstellt
□ Templates kopiert
□ Status-Report erstellt und angepasst
□ Git Repository initialisiert
□ Erste Dokumentation committed

Dateien die existieren sollten:
├── projektname_status_report.md (angepasst!)
├── /docs/sgit_project_template.md
├── /docs/sgit_quick_start_guide.md
├── /core/ (leer)
├── /modules/ (leer)
├── /assets/ (leer)
├── /logs/ (leer)
└── /database/ (leer)
```

### Phase 2: Planning (Tag 1-2)

```
□ Requirements im Status-Report dokumentiert
□ Tech Stack festgelegt
□ Database Schema designed
□ UI/UX Mockups erstellt (optional)
□ Erste TODOs definiert

Status-Report Bereiche ausgefüllt:
✓ Projekt-Übersicht
✓ Technologie-Stack
✓ Database Schema (Entwurf)
✓ Nächste Schritte (erste TODOs)
```

### Phase 3: Development Start (Tag 2+)

```
□ config.php erstellt mit DB-Settings
□ database.php mit Connection Logic
□ Erste Tabelle(n) angelegt
□ index.php als Entry Point
□ Erste Module-Struktur

Git Commits:
✓ INIT: Project setup
✓ FEAT: Database schema created
✓ FEAT: Core configuration added
✓ DOCS: Updated status report
```

---

## 💻 ENTWICKLUNGS-WORKFLOW

### Täglich - Session Start

```
1. Status-Report öffnen & lesen
   → [projekt]_status_report.md

2. Aktuellen Stand prüfen
   → Was funktioniert?
   → Was ist offen?
   → Was ist die höchste Priorität?

3. In Claude einfügen:
   "Lies bitte [projekt]_status_report.md und 
    fasse den aktuellen Stand zusammen."

4. Development starten
   → Fokus auf höchste Priorität
   → Iterativ arbeiten
   → Kontinuierlich dokumentieren
```

### Während Development

```
Bei jeder Funktion:
1. File Header checken (Version aktuell?)
2. Function Header schreiben
3. Implementation
4. Testing
5. Logging hinzufügen (bei Komplexität)
6. Kommentierung

Bei jedem Problem:
1. Problem im Status-Report dokumentieren
2. Debug-Log-Sektion nutzen
3. Iterativ fixen (v1.0, v1.1, v1.2...)
4. Lösung dokumentieren
5. Lessons Learned festhalten
```

### Session Ende

```
1. Status-Report aktualisieren
   ✓ Was wurde gemacht?
   ✓ Was funktioniert jetzt?
   ✓ Was ist noch offen?
   ✓ Lessons Learned?

2. Git Commit
   git add .
   git commit -m "[TYPE]: Clear description"
   git push

3. Backup (optional)
   cp database/projekt.db backups/projekt_$(date +%Y%m%d).db

4. TODOs für nächste Session notieren
```

---

## 📚 ARCHIV-WORKFLOW (NEU in v1.2)

### Wann archivieren?

**Trigger:** Status-Report hat > 500 Zeilen

**Warum 500 Zeilen?**
- AI-Assistenten (Claude, etc.) haben Token-Limits
- Große Dokumente können Chat-Stabilität beeinträchtigen
- Schnellerer Kontext-Aufbau bei Session-Start

### Wie archivieren?

```bash
# 1. Prüfe Zeilenzahl
wc -l projekt_status_report.md
# Falls > 500 Zeilen:

# 2. Erstelle Archiv-Datei
touch projekt_ARCHIVE.md

# 3. Verschiebe in Archiv:
#    - Geschlossene Bugs (alle mit ✅)
#    - Alte Session-Logs (außer aktuelle)
#    - Versions-Historie (alte Einträge)
#    - Abgeschlossene Milestones

# 4. Behalte im aktiven Report:
#    - Quick-Start Section (OBEN!)
#    - Offene TODOs
#    - Aktuelle/Offene Bugs
#    - Aktuelle Session
#    - Technische Details

# 5. Füge Archiv-Verweis am Ende hinzu
```

### Archiv-Datei Struktur

```markdown
# [PROJEKTNAME] - ARCHIV

**Archiviert am:** [DATUM]
**Grund:** Status-Report > 500 Zeilen

---

## 📜 GESCHLOSSENE BUGS
[Alle geschlossenen Bugs hier]

## 📝 SESSION-HISTORIE
[Alte Sessions hier]

## 🔄 VERSIONS-HISTORIE
[Alte Versionen hier]

## ✅ ABGESCHLOSSENE MILESTONES
[Erledigte Meilensteine hier]
```

### Best Practices

```
✅ Quick-Start Section IMMER ganz oben
✅ Archiv-Verweis am Ende des aktiven Reports
✅ Archiv chronologisch sortieren (neueste oben)
✅ Regelmäßig prüfen (alle 2-4 Wochen)
✅ Bei großen Projekten: Pro Quartal archivieren
```

---

## 🎯 TEMPLATE-NUTZUNG FÜR VERSCHIEDENE PROJEKT-TYPEN

### Kleines Projekt (1-2 Wochen)

**Verwende:**
- Status-Report Template (vollständig)
- Quick-Start Guide (als Referenz)

**Überspringe:**
- Team-Kommunikations-Sektionen
- Deployment-Environments
- Extensive Testing-Dokumentation

**Fokus:**
- Core-Features schnell implementieren
- Essentials dokumentieren
- Quick-TODOs abarbeiten

---

### Mittleres Projekt (1-3 Monate)

**Verwende:**
- Alle Templates vollständig
- Systematische Dokumentation
- Regelmäßige Status-Updates

**Wichtig:**
- Lessons Learned gewissenhaft führen
- Debug-Logs detailliert
- Versions-History pflegen

**Fokus:**
- Saubere Code-Struktur
- Umfassende Tests
- Performance-Optimierung

---

### Großes Projekt (3+ Monate)

**Verwende:**
- Master-Template als Bibel
- Wöchentliche Status-Reports
- Team-Dokumentation
- Alle Testing-Frameworks

**Zusätzlich:**
- Separate API-Dokumentation
- User-Manuals
- Admin-Guides
- Deployment-Runbooks

**Fokus:**
- Skalierbarkeit
- Maintainability
- Comprehensive Documentation
- Team Collaboration

---

## 📝 ANPASSUNG DER TEMPLATES

### Was du IMMER anpassen solltest:

```markdown
# Im Status-Report:
[PROJEKTNAME] → Echter Projektname
[DATUM] → Aktuelles Datum
[X.Y.Z] → Aktuelle Version
[HEX-CODE] → Echte Farbcodes
[Feature] → Echte Features

# Im Code:
[name] → Variable Namen
[path] → Echte Pfade
[url] → Echte URLs
```

### Was du OPTIONAL anpassen kannst:

- Ordnerstruktur (je nach Projekt-Größe)
- Sektion-Reihenfolge (was für dich logischer ist)
- Detail-Level (mehr/weniger detailliert)
- Zusätzliche Sektionen (projektspezifisch)

### Was du NIEMALS ändern solltest:

- Core-Prinzipien (Documentation First, etc.)
- Debug-Workflow (bewährte Methodik)
- Versions-System (Semantic Versioning)
- Logging-Struktur (für Konsistenz)

---

## 🔄 TEMPLATE-WARTUNG

### Monatlich Review

```
□ Neue Lessons Learned einarbeiten
□ Veraltete Sektionen entfernen
□ Best Practices updaten
□ Beispiele erweitern
```

### Nach jedem Projekt

```
□ Was hat gut funktioniert? → Template
□ Was hat nicht funktioniert? → Template
□ Neue Patterns erkannt? → Template
□ Tools-Changes? → Template aktualisieren
```

### Template-Versionierung

```
sgit_project_template_v1.0.md (Initial)
sgit_project_template_v1.1.md (Verbesserungen)
sgit_project_template_v2.0.md (Major Update)

Immer Changelog pflegen!
```

---

## 🎓 BEST PRACTICES

### DO's ✅

```
✅ Status-Report bei JEDER Session lesen
✅ Kontinuierlich dokumentieren (nicht am Ende)
✅ Code kommentieren WÄHREND dem Schreiben
✅ Probleme sofort dokumentieren (nicht aufschieben)
✅ Lessons Learned zeitnah festhalten
✅ Iterativ vorgehen (kleine Schritte)
✅ Testing vor Deployment
✅ Git-Commits mit klaren Messages
✅ Backup-Strategie einhalten
✅ Template an Projekt anpassen
```

### DON'Ts ❌

```
❌ Dokumentation aufschieben
❌ Ohne Logging debuggen
❌ Direkt in Production coden
❌ Versionierung ignorieren
❌ Commits ohne Message
❌ Testing überspringen
❌ Security ignorieren
❌ Performance vergessen
❌ Code ohne Comments
❌ Template blind kopieren ohne Anpassung
```

---

## 🔍 TROUBLESHOOTING

### Problem: "Templates sind zu umfangreich"

**Lösung:**
- Nutze den Quick-Start Guide für tägliche Arbeit
- Master-Template ist Referenz, nicht Daily-Driver
- Passe Templates an Projekt-Größe an
- Entferne nicht-relevante Sektionen

### Problem: "Zu viel Dokumentations-Overhead"

**Lösung:**
- Dokumentiere WÄHREND Development (nicht danach)
- Nutze Copy-Paste aus Quick-Start
- 5 Minuten pro Session für Updates = spart Stunden später
- Template wird schneller je öfter du es nutzt

### Problem: "Vergesse Status-Report zu lesen"

**Lösung:**
- Setze Reminder im Kalender
- Erste Zeile in jedem Claude-Chat: "Lies Status-Report"
- Status-Report als Browser-Startseite
- Post-It am Monitor: "STATUS REPORT FIRST!"

### Problem: "Templates passen nicht zu meinem Workflow"

**Lösung:**
- Templates sind Ausgangspunkt, keine Religion
- Anpassen ist erlaubt und erwünscht
- Behalte Core-Prinzipien bei
- Erstelle eigene Variante basierend auf Erfahrung

---

## 📊 ERFOLGS-METRIKEN

### Du nutzt Templates erfolgreich wenn:

```
✅ Du kannst nach 2 Wochen Pause sofort weitermachen
✅ Andere können dein Projekt verstehen
✅ Bugs werden schneller gefunden und gefixt
✅ Du wiederholst keine Fehler
✅ Code-Qualität ist konsistent
✅ Dokumentation ist immer aktuell
✅ Testing ist systematisch
✅ Deployment läuft reibungslos
✅ Lessons Learned helfen in neuen Projekten
✅ Du sparst Zeit statt sie zu verschwenden
```

---

## 🚀 NÄCHSTE SCHRITTE

### Sofort:

```
1. Templates an sicheren Ort speichern
   → ~/Development/sgiT_Templates/
   
2. Backup erstellen
   → Cloud Sync (Google Drive, Dropbox, etc.)
   
3. Git Repository für Templates
   → git init in Templates-Ordner
   → Versionierung der Templates selbst
```

### Diese Woche:

```
4. Templates bei nächstem Projekt nutzen
   → Vollständig durchgehen
   → Anpassungen dokumentieren
   
5. Erste Erfahrungen sammeln
   → Was funktioniert gut?
   → Was muss angepasst werden?
```

### Diesen Monat:

```
6. Templates basierend auf Erfahrung anpassen
   → Eigene Best Practices integrieren
   → Projektspezifische Sektionen hinzufügen
   
7. Team (falls vorhanden) schulen
   → Templates vorstellen
   → Gemeinsame Standards definieren
```

---

## 💡 PRO-TIPPS

### Tip #1: Template-Repository
```bash
# Erstelle ein Git-Repo nur für Templates
mkdir ~/sgiT_Templates
cd ~/sgiT_Templates
git init

# Alle Templates hier ablegen
cp *.md ~/sgiT_Templates/

# Bei Updates committen
git add .
git commit -m "UPDATE: Neue Lessons Learned"
```

### Tip #2: Projekt-Generator Script
```bash
# Erweitere das neue-projekt-script um:
- Automatisches Git-Repo erstellen
- Erste Commits machen
- .gitignore anlegen
- README.md generieren
- Claude mit richtigem Prompt starten
```

### Tip #3: IDE-Integration
```
# Füge Templates zu deiner IDE hinzu:
VS Code: File Templates Extension
PHPStorm: File and Code Templates
Sublime: Snippets

Shortcut: "sgit-header" → File Header einfügen
Shortcut: "sgit-func" → Function Header einfügen
```

### Tip #4: Claude Custom Instructions
```
# In Claude Projekt-Settings:
"Bei jedem Chat zu [Projekt]:
1. Lies [projekt]_status_report.md
2. Fasse aktuellen Stand zusammen
3. Identifiziere nächste Schritte
4. Dokumentiere alle Änderungen im Report"
```

### Tip #5: Automated Backups
```bash
# Cronjob für tägliche Backups:
0 2 * * * /home/user/scripts/backup_projects.sh

# backup_projects.sh:
#!/bin/bash
tar -czf backup_$(date +%Y%m%d).tar.gz /xampp/htdocs/
# Upload to cloud or external drive
```

---

## 📚 ZUSÄTZLICHE RESSOURCEN

### In Templates enthalten:

- ✅ Comprehensive Status-Report Structure
- ✅ Debug-Workflow Methodology
- ✅ Code-Quality Standards
- ✅ Testing Frameworks
- ✅ Security Best Practices
- ✅ Deployment Checklists
- ✅ Lessons Learned Format

### Nicht enthalten (bei Bedarf ergänzen):

- ❌ Projektspezifische API-Docs
- ❌ Team-spezifische Workflows
- ❌ Client-spezifische Requirements
- ❌ Domain-spezifisches Wissen
- ❌ Tool-spezifische Guides

### Externe Ressourcen:

```
Git: https://git-scm.com/doc
PHP: https://www.php.net/docs.php
SQLite: https://www.sqlite.org/docs.html
Security: https://owasp.org/
Testing: https://phpunit.de/
```

---

## 🎯 FAZIT

### Diese Templates geben dir:

```
✅ Konsistente Projekt-Struktur
✅ Systematischen Entwicklungs-Prozess
✅ Effektiven Debug-Workflow
✅ Umfassende Dokumentation
✅ Bewährte Best Practices
✅ Wiederkehrende Patterns
✅ Lessons-Learned-System
✅ Professionelle Code-Qualität
```

### Damit sparst du:

```
💰 Zeit bei jedem neuen Projekt
💰 Zeit beim Debugging
💰 Zeit bei Dokumentation
💰 Zeit beim Onboarding
💰 Zeit bei Code-Reviews
💰 Zeit bei Maintenance
```

### Investiere jetzt 1 Stunde:

```
→ Templates durchlesen und verstehen
→ Bei nächstem Projekt nutzen
→ Nach Projekt-Ende anpassen
→ Kontinuierlich verbessern

= Spare 10+ Stunden pro Projekt!
```

---

**Erstellt:** 2024-12-01  
**Version:** 1.0  
**Basiert auf:** 19 Jahre IT-Erfahrung + sgiT Education Platform  
**Maintained by:** deStevie / sgiT Solution Engineering

═══════════════════════════════════════════════════════════
VIEL ERFOLG MIT DEINEN ZUKÜNFTIGEN PROJEKTEN! 🚀
═══════════════════════════════════════════════════════════
