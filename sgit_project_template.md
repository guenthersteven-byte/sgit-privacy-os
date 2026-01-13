# sgiT Projekt-Template
## Systematischer Entwicklungs- und Debug-Prozess

**Version:** 1.2  
**Letzte Aktualisierung:** 2025-12-08  
**Maintained by:** deStevie / sgiT Solution Engineering

---

## 🚀 QUICK START (Für neue Chat-Sessions)

> **📌 WICHTIG:** Bei JEDEM neuen Chat zuerst den Status-Report lesen!

```
1. Status-Report öffnen:    [projekt]_status_report.md
2. Aktuellen Stand prüfen:  Was funktioniert? Was nicht?
3. TODOs identifizieren:    Was ist die höchste Priorität?
4. Mit Claude starten:      "Lies bitte [projekt]_status_report.md"
```

### Wichtigste Befehle (Docker)
```bash
# Container starten
docker-compose up -d

# Container stoppen
docker-compose down

# Logs anzeigen
docker-compose logs -f [service]

# In Container einloggen
docker exec -it [container] bash
```

---

## ⚠️ ARCHIV-STRATEGIE

> **Wenn dieses Dokument oder der Status-Report > 500 Zeilen:**
> 1. Erstelle `[PROJEKTNAME]_ARCHIVE.md`
> 2. Verschiebe: Abgeschlossene Sektionen, alte Erkenntnisse
> 3. Behalte: Aktive Sektionen, aktuelle Best Practices
> 4. Grund: AI-Chat-Stabilität, Token-Limit schonen

---

## 📋 PROJEKT-GRUNDLAGEN

### Projekt-Informationen
```
Projektname: [NAME]
Version: [SEMANTIC VERSION - z.B. 1.0.0]
Erstellt am: [DATUM]
Lead Developer: deStevie
Status: [Planning/Development/Testing/Production]
```

### Technologie-Stack
```
- Backend: [z.B. PHP 8.x]
- Database: [z.B. SQLite/MySQL]
- Frontend: [z.B. HTML5/CSS3/JavaScript]
- Server: [z.B. Docker/nginx/PHP-FPM oder XAMPP]
- AI/ML: [z.B. Ollama mit gemma2:2b]
- Additional Tools: [Liste weiterer Tools]
```

---

## 🐳 DOCKER BEST PRACTICES

### Warum Docker?
- **Konsistente Umgebung** - Keine "works on my machine" Probleme
- **Isolierung** - Jedes Projekt in eigenem Container
- **Reproduzierbar** - Gleiche Umgebung auf jedem System
- **Skalierbar** - Einfache Erweiterung und Deployment

### Standard docker-compose.yml Struktur
```yaml
version: '3.8'

services:
  # Webserver (nginx)
  nginx:
    image: nginx:alpine
    container_name: ${PROJECT}_nginx
    ports:
      - "8080:80"
    volumes:
      - ./src:/var/www/html
      - ./docker/nginx/default.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - php
    networks:
      - app-network

  # PHP-FPM
  php:
    build:
      context: ./docker/php
      dockerfile: Dockerfile
    container_name: ${PROJECT}_php
    volumes:
      - ./src:/var/www/html
    networks:
      - app-network

  # AI Service (Optional)
  ollama:
    image: ollama/ollama
    container_name: ${PROJECT}_ollama
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama
    networks:
      - app-network

networks:
  app-network:
    driver: bridge

volumes:
  ollama_data:
```

### Docker-Befehle Cheat-Sheet
```bash
# === CONTAINER MANAGEMENT ===
docker-compose up -d              # Starten (detached)
docker-compose down               # Stoppen + entfernen
docker-compose restart            # Neustarten
docker-compose ps                 # Status anzeigen

# === LOGS ===
docker-compose logs -f            # Alle Logs (follow)
docker-compose logs -f php        # Nur PHP Logs
docker logs [container] --tail 50 # Letzte 50 Zeilen

# === DEBUGGING ===
docker exec -it [container] bash  # Shell im Container
docker exec -it [container] sh    # Für Alpine Images

# === PHP-BEFEHLE IM CONTAINER ===
docker exec -it sgit_php php /var/www/html/script.php
docker exec -it sgit_php composer install

# === CLEANUP ===
docker system prune -a            # Alles aufräumen (VORSICHT!)
docker volume prune               # Ungenutzte Volumes löschen
```

### Docker PHP Dockerfile Beispiel
```dockerfile
FROM php:8.3-fpm

# Extensions installieren
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite

# Timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime

# Working Directory
WORKDIR /var/www/html
```

### Wichtige Regeln
```
✅ IMMER docker exec für PHP-Befehle nutzen
✅ Volumes für persistente Daten
✅ .env für Konfiguration (nicht im Repo!)
✅ Container-Namen mit Projekt-Prefix
✅ Networks für Service-Kommunikation

❌ NIEMALS lokale PHP-Befehle bei Docker-Setup
❌ KEINE Passwörter in docker-compose.yml
❌ NICHT direkt in Container schreiben (geht bei Restart verloren)
```

---

## 🎯 ENTWICKLUNGSPRINZIPIEN

### 1. Documentation-First Ansatz
**REGEL: Vor jedem neuen Chat IMMER Status-Report lesen!**

```
[PROJEKT]_status_report.md IMMER als erstes öffnen
- Aktueller Stand erfassen
- Offene TODOs prüfen
- Letzte Änderungen nachvollziehen
```

### 2. Systematisches Debugging
**Niemals blind coden - immer dokumentieren!**

#### Debug-Workflow:
1. **Problem identifizieren**
   - Exakte Fehlerbeschreibung
   - Reproduzierbare Schritte
   - Erwartetes vs. tatsächliches Verhalten

2. **Logging implementieren**
   - Detaillierte Log-Ausgaben
   - Zeitstempel für alle Ereignisse
   - Verschiedene Log-Level (INFO, DEBUG, ERROR)

3. **Iterative Verbesserung**
   - Version numbering (v1.0, v1.1, etc.)
   - Jede Änderung dokumentieren
   - Rückwärtskompatibilität beachten

4. **Testing vor Deployment**
   - Funktionale Tests
   - Edge Cases prüfen
   - Performance testen

### 3. Code-Qualität Standards

#### Kommentierung:
```php
/**
 * [FUNKTIONSNAME] - Version [X.Y]
 * 
 * Beschreibung: [Was macht die Funktion]
 * 
 * @param [TYPE] $param - [Beschreibung]
 * @return [TYPE] - [Was wird zurückgegeben]
 * 
 * Änderungshistorie:
 * - v1.0: Initiale Implementation
 * - v1.1: Bug-Fix für [Problem]
 * - v1.2: Performance-Optimierung
 */
function beispielFunktion($param) {
    // Implementation
}
```

#### File Headers:
```php
/**
 * ═══════════════════════════════════════════════════
 * [DATEINAME]
 * ═══════════════════════════════════════════════════
 * 
 * Projekt: [PROJEKTNAME]
 * Version: [VERSION]
 * Erstellt: [DATUM]
 * Letzte Änderung: [DATUM]
 * 
 * Beschreibung:
 * [Kurze Beschreibung des Datei-Zwecks]
 * 
 * Abhängigkeiten:
 * - [Externe Bibliotheken/Dateien]
 * 
 * ═══════════════════════════════════════════════════
 */
```

---

## 📊 STATUS-REPORT STRUKTUR

### Dateiname: `[projekt]_status_report.md`

```markdown
# [PROJEKTNAME] - Status Report
**Letzte Aktualisierung:** [DATUM + ZEIT]
**Version:** [SEMANTIC VERSION]

---

## 🎯 PROJEKT-ÜBERSICHT

### Zweck
[Warum existiert dieses Projekt?]

### Zielgruppe
[Für wen ist es gedacht?]

### Hauptfeatures
1. [Feature 1]
2. [Feature 2]
3. [Feature 3]

---

## 📈 AKTUELLER STATUS

### Was funktioniert ✅
- [Liste aller funktionierenden Features]
- [Mit Versions-Nummern]

### In Bearbeitung 🔄
- [Aktuelle Tasks]
- [Mit geschätztem Fertigstellungsdatum]

### Bekannte Probleme ⚠️
- [Problem 1]: [Beschreibung + Workaround]
- [Problem 2]: [Beschreibung + Geplante Lösung]

---

## 🗂️ DATEISTRUKTUR

```
/projekt_root/
├── /core/              # Kern-Funktionalität
├── /modules/           # Einzelne Module
├── /assets/           # CSS, JS, Images
├── /logs/             # Log-Dateien
├── /database/         # DB-Dateien
├── /tests/            # Test-Suites
└── README.md          # Projekt-Dokumentation
```

---

## 🔧 TECHNISCHE DETAILS

### Database Schema
[Tabellen-Struktur dokumentieren]

### API Endpoints
[Falls vorhanden, alle Endpoints]

### Configuration
[Wichtige Config-Parameter]

---

## 📝 ÄNDERUNGSHISTORIE

### Version [X.Y.Z] - [DATUM]
**Typ:** [Feature/Bugfix/Optimization]

**Änderungen:**
- [Detaillierte Beschreibung]
- [Betroffene Dateien]
- [Grund für Änderung]

**Testing:**
- [Was wurde getestet]
- [Ergebnisse]

---

## 🎯 NÄCHSTE SCHRITTE

### Kurzfristig (Diese Woche)
1. [Task 1] - Priorität: [Hoch/Mittel/Niedrig]
2. [Task 2] - Geschätzte Zeit: [X Stunden]

### Mittelfristig (Dieser Monat)
1. [Milestone 1]
2. [Milestone 2]

### Langfristig (Dieses Quartal)
1. [Große Feature-Erweiterungen]
2. [Architektur-Verbesserungen]

---

## 💡 LESSONS LEARNED

### Was hat gut funktioniert
- [Erfolgreiche Ansätze]
- [Wiederverwendbare Patterns]

### Was hat nicht funktioniert
- [Fehler-Ansätze]
- [Zu vermeidende Anti-Patterns]

### Optimierungspotenzial
- [Bereiche für Verbesserung]
- [Performance-Optimierungen]

---

## 🔍 DEBUG-LOG

### [DATUM] - [PROBLEM-BESCHREIBUNG]
**Symptom:** [Was war das Problem?]
**Ursache:** [Root Cause Analysis]
**Lösung:** [Wie wurde es behoben?]
**Verhinderung:** [Wie wird es künftig verhindert?]

```

---

## 🔄 ITERATIVER ENTWICKLUNGSPROZESS

### Phase 1: Planning
```
✓ Requirements definieren
✓ User Stories erstellen
✓ Technologie-Stack festlegen
✓ Datenbankschema entwerfen
✓ UI/UX Mockups erstellen
```

### Phase 2: Development
```
✓ Core-Funktionalität implementieren
✓ Modul für Modul aufbauen
✓ Kontinuierliche Dokumentation
✓ Code Reviews durchführen
✓ Version Control nutzen
```

### Phase 3: Testing
```
✓ Unit Tests schreiben
✓ Integration Tests
✓ User Acceptance Testing
✓ Performance Testing
✓ Security Audit
```

### Phase 4: Deployment
```
✓ Staging Environment testen
✓ Production Deployment
✓ Monitoring einrichten
✓ Backup-Strategie
✓ Rollback-Plan
```

### Phase 5: Maintenance
```
✓ Bug-Fixes
✓ Feature-Erweiterungen
✓ Performance-Optimierung
✓ Security Updates
✓ Dokumentation aktualisieren
```

---

## 🎨 BRANDING & DESIGN GUIDELINES

### Corporate Identity
```
Primärfarbe: [HEX-CODE]
Sekundärfarbe: [HEX-CODE]
Akzentfarbe: [HEX-CODE]
Schriftart: [FONT-FAMILIE]
Logo-Pfad: [PFAD]
```

### Konsistenz-Regeln
- Alle Seiten nutzen identische Navigation
- Einheitliche Button-Styles
- Konsistente Fehlermeldungen
- Gleiche Erfolgs-Meldungen
- Unified Progress Tracking

---

## 💾 BACKUP-STRATEGIE

### 3-2-1 Backup Regel
```
3 Kopien deiner Daten
2 verschiedene Medien (lokal + cloud)
1 Offsite-Backup (Cloud)
```

### Backup-Typen

#### 1. Automatisches lokales Backup
```bash
#!/bin/bash
# backup_local.sh - Täglich per Cronjob

PROJECT="[projektname]"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups/${PROJECT}"

mkdir -p ${BACKUP_DIR}

# Datenbank
cp /path/to/database.db ${BACKUP_DIR}/db_${DATE}.db

# Projekt-Dateien (ohne node_modules, vendor)
tar -czf ${BACKUP_DIR}/files_${DATE}.tar.gz \
    --exclude='node_modules' \
    --exclude='vendor' \
    --exclude='.git' \
    /path/to/project

# Alte Backups löschen (älter als 7 Tage)
find ${BACKUP_DIR} -type f -mtime +7 -delete

echo "[${DATE}] Backup completed"
```

#### 2. Cloud-Sync (OneDrive/Google Drive)
```bash
# Struktur für Cloud-Sync
~/OneDrive/
├── Projekte/
│   └── [projektname]/
│       ├── backups/           # Automatische Backups
│       ├── docs/              # Dokumentation
│       └── exports/           # Wichtige Exports
```

#### 3. Git für Code-Versionierung
```bash
# Regelmäßige Commits
git add .
git commit -m "[TYPE]: Description"
git push origin main

# Branches für Features
git checkout -b feature/[name]
```

### Backup-Schedule

| Was | Wann | Wo | Retention |
|-----|------|-------|-----------|
| **Database** | Täglich | Lokal + Cloud | 7 Tage |
| **Config Files** | Bei Änderung | Git | Unbegrenzt |
| **Uploads/Media** | Wöchentlich | Cloud | 30 Tage |
| **Full Backup** | Monatlich | External Drive | 1 Jahr |

### Restore-Prozedur
```bash
# 1. Backup-Datei identifizieren
ls -la /backups/[projekt]/

# 2. Datenbank wiederherstellen
cp /backups/[projekt]/db_[date].db /path/to/database.db

# 3. Dateien wiederherstellen
tar -xzf /backups/[projekt]/files_[date].tar.gz -C /restore/

# 4. Berechtigungen prüfen
chmod -R 755 /path/to/project
chown -R www-data:www-data /path/to/project
```

### Backup-Checkliste
```
□ Cronjob für tägliche Backups eingerichtet?
□ Cloud-Sync aktiv (OneDrive/Google Drive)?
□ Git Repository aktuell?
□ Restore-Prozedur getestet?
□ Backup-Logs werden überwacht?
□ Offsite-Backup vorhanden?
```

---

## 📁 LOGGING-SYSTEM

### Log-Datei Struktur
```
/logs/
├── error_log.txt           # Fehler
├── debug_log.txt           # Debug-Informationen
├── access_log.txt          # Zugriffe
└── performance_log.txt     # Performance-Metriken
```

### Log-Format
```
[TIMESTAMP] [LEVEL] [FILE:LINE] - Message
Beispiel:
[2024-12-01 14:23:45] [ERROR] [ai_generator.php:127] - AI Response parsing failed
```

### Log-Levels
```
ERROR   - Kritische Fehler
WARNING - Warnungen
INFO    - Informative Meldungen
DEBUG   - Detaillierte Debug-Infos
```

---

## 🤖 AI/OLLAMA BEST PRACTICES

### Model-Auswahl Entscheidungsbaum

| Anforderung | Empfohlenes Modell | RAM | Qualität |
|-------------|-------------------|-----|----------|
| **Standard (empfohlen)** | `gemma2:2b` | 4-6 GB | ⭐⭐⭐⭐ |
| Schnell + klein | `llama3.2:1b` | 2-3 GB | ⭐⭐⭐ |
| Nur Chatbot | `tinyllama` | 1-2 GB | ⭐⭐ |
| Hohe Qualität (GPU!) | `mistral:7b` | 8+ GB | ⭐⭐⭐⭐⭐ |
| Coding-Tasks | `codellama:7b` | 8+ GB | ⭐⭐⭐⭐⭐ |

### Ollama Setup
```bash
# Model herunterladen
docker exec sgit_ollama ollama pull gemma2:2b

# Verfügbare Modelle anzeigen
docker exec sgit_ollama ollama list

# Model testen
docker exec sgit_ollama ollama run gemma2:2b "Hello, how are you?"

# Model entfernen
docker exec sgit_ollama ollama rm [model]
```

### API-Aufruf (PHP Beispiel)
```php
function callOllama($prompt, $model = 'gemma2:2b') {
    $url = 'http://ollama:11434/api/generate';
    
    $data = [
        'model' => $model,
        'prompt' => $prompt,
        'stream' => false,
        'options' => [
            'temperature' => 0.7,
            'num_predict' => 500
        ]
    ];
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
    curl_setopt($ch, CURLOPT_TIMEOUT, 120);
    
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true);
}
```

### Best Practices
```
✅ Model-Konfiguration in separater Datei (nicht hardcoded)
✅ Timeout erhöhen (AI braucht Zeit)
✅ Graceful Degradation wenn Ollama offline
✅ Response-Caching für wiederholte Anfragen
✅ Rate-Limiting implementieren

❌ KEINE sensiblen Daten an AI senden
❌ NICHT auf AI-Antworten blind vertrauen
❌ KEINE Produktionsentscheidungen ohne Validierung
```

### Performance-Tipps
```
1. CPU-only: gemma2:2b oder kleiner
2. Mit GPU: mistral:7b oder größer
3. Context-Length beachten (max ~4096 Token)
4. Batch-Requests vermeiden (einzeln ist stabiler)
5. Health-Check vor Anfrage: curl http://localhost:11434/
```

---

## 🧪 TESTING FRAMEWORK

### Test-Arten

#### 1. Function Tests
```php
/**
 * Test: [FUNKTION]
 * Expected: [ERWARTETES ERGEBNIS]
 * Actual: [TATSÄCHLICHES ERGEBNIS]
 * Status: [PASS/FAIL]
 */
```

#### 2. Integration Tests
- Module-Interaktion testen
- API-Calls validieren
- Datenbank-Operationen prüfen

#### 3. Load Tests
- Performance unter Last
- Concurrent User Testing
- Response Time Monitoring

#### 4. Security Tests
- SQL Injection Prävention
- XSS Protection
- CSRF Token Validation
- Input Sanitization

---

## 🔐 SECURITY BEST PRACTICES

### Input Validation
```php
// IMMER User Input validieren
$clean_input = filter_var($input, FILTER_SANITIZE_STRING);

// Prepared Statements für DB
$stmt = $pdo->prepare("SELECT * FROM table WHERE id = ?");
$stmt->execute([$id]);
```

### Error Handling
```php
// Fehler loggen, nicht anzeigen
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_log($error_message);
```

### Session Management
```php
// Sichere Session Configuration
session_start([
    'cookie_httponly' => true,
    'cookie_secure' => true,
    'cookie_samesite' => 'Strict'
]);
```

---

## ⚙️ ENVIRONMENT VARIABLES

### Warum .env?
- **Sicherheit** - Keine Secrets im Code/Git
- **Flexibilität** - Unterschiedliche Configs pro Umgebung
- **Wartbarkeit** - Zentrale Konfiguration

### Standard .env Struktur
```bash
# .env (NIEMALS in Git!)

# === APP SETTINGS ===
APP_NAME="[Projektname]"
APP_ENV=development
APP_DEBUG=true
APP_URL=http://localhost:8080

# === DATABASE ===
DB_CONNECTION=sqlite
DB_DATABASE=/var/www/html/database/app.db
# Für MySQL:
# DB_HOST=mysql
# DB_PORT=3306
# DB_DATABASE=projektname
# DB_USERNAME=user
# DB_PASSWORD=secret

# === AI/OLLAMA ===
OLLAMA_HOST=http://ollama:11434
OLLAMA_MODEL=gemma2:2b
OLLAMA_TIMEOUT=120

# === SECURITY ===
SESSION_LIFETIME=120
ADMIN_PASSWORD=changeme

# === EXTERNAL APIS (falls benötigt) ===
# BITCOIN_API_KEY=xxx
# SMTP_HOST=smtp.example.com
```

### .env laden (PHP)
```php
// Am Anfang von config.php oder index.php
function loadEnv($path = '.env') {
    if (!file_exists($path)) return;
    
    $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos(trim($line), '#') === 0) continue;
        if (strpos($line, '=') === false) continue;
        
        list($name, $value) = explode('=', $line, 2);
        $name = trim($name);
        $value = trim($value, '"\'');
        
        putenv("$name=$value");
        $_ENV[$name] = $value;
    }
}

loadEnv(__DIR__ . '/.env');

// Verwendung:
$dbPath = getenv('DB_DATABASE') ?: '/default/path.db';
```

### .gitignore für .env
```gitignore
# Environment
.env
.env.local
.env.*.local

# Aber .env.example committen!
!.env.example
```

### .env.example (Template für Repo)
```bash
# .env.example - Kopiere zu .env und fülle aus

APP_NAME="[Projektname]"
APP_ENV=development
APP_DEBUG=true

DB_CONNECTION=sqlite
DB_DATABASE=/path/to/database.db

OLLAMA_HOST=http://localhost:11434
OLLAMA_MODEL=gemma2:2b
```

---

## 📞 KOMMUNIKATION MIT CLAUDE

### Optimale Chat-Strategie

#### Session Start:
```
1. Status-Report lesen
2. Aktuellen Stand zusammenfassen
3. Nächste Schritte definieren
```

#### Während Development:
```
1. Klare, technische Kommunikation
2. Konkrete Problembeschreibungen
3. Code-Beispiele bereitstellen
4. Erwartete Ergebnisse spezifizieren
```

#### Session End:
```
1. Alle Änderungen dokumentieren
2. Status-Report aktualisieren
3. TODOs für nächste Session notieren
```

---

## 🎓 PROJEKTSPEZIFISCHE ERKENNTNISSE

### [ERKENNTNIS 1]
**Problem:** [Beschreibung]
**Lösung:** [Wie gelöst]
**Anwendbar auf:** [Andere Bereiche]

### [ERKENNTNIS 2]
**Problem:** [Beschreibung]
**Lösung:** [Wie gelöst]
**Anwendbar auf:** [Andere Bereiche]

---

## 📚 ZUSÄTZLICHE DOKUMENTATION

### README.md
- Projekt-Übersicht
- Installation Guide
- Quick Start
- FAQ

### INSTALL.md
- System Requirements
- Schritt-für-Schritt Installation
- Configuration
- Troubleshooting

### API.md
- Endpoint Dokumentation
- Request/Response Formats
- Authentication
- Rate Limiting

---

## ✅ PRE-DEPLOYMENT CHECKLIST

```
□ Alle Tests passed
□ Code Review durchgeführt
□ Dokumentation aktualisiert
□ Security Audit abgeschlossen
□ Performance-Tests bestanden
□ Backup erstellt
□ Rollback-Plan vorhanden
□ Monitoring eingerichtet
□ Team informiert
□ Deployment-Zeitfenster geplant
```

---

## 🚀 POST-DEPLOYMENT MONITORING

### Erste 24 Stunden
- [ ] Error Logs überwachen
- [ ] Performance metriken prüfen
- [ ] User Feedback sammeln
- [ ] Quick-Fix bereithalten

### Erste Woche
- [ ] Detaillierte Analytics
- [ ] User Behavior Analysis
- [ ] Performance Optimization
- [ ] Bug-Fix Releases

---

## 📊 METRICS & KPIs

### Technical Metrics
```
- Page Load Time: [TARGET]
- API Response Time: [TARGET]
- Error Rate: [< X%]
- Uptime: [> 99.X%]
```

### Business Metrics
```
- User Engagement: [METRIC]
- Completion Rate: [METRIC]
- User Satisfaction: [METRIC]
```

---

## 🔄 VERSION CONTROL

### Git Workflow
```bash
# Feature Development
git checkout -b feature/[name]
# ... development ...
git commit -m "[TYPE]: Clear description"
git push origin feature/[name]

# Commit Types:
# FEAT: New feature
# FIX: Bug fix
# DOCS: Documentation
# STYLE: Formatting
# REFACTOR: Code restructuring
# TEST: Adding tests
# CHORE: Maintenance
```

---

## 💬 TEAM KOMMUNIKATION

### Status Updates
- Tägliche Stand-ups
- Weekly Progress Reports
- Monthly Reviews
- Quarterly Planning

### Issue Tracking
- Bug Reports mit Template
- Feature Requests mit Priorität
- Technical Debt Documentation

---

## 🎯 KONTINUIERLICHE VERBESSERUNG

### Quarterly Reviews
1. Was lief gut?
2. Was kann verbessert werden?
3. Neue Tools/Technologien?
4. Team-Feedback einarbeiten

### Learning & Development
- Neue Technologien evaluieren
- Best Practices updaten
- Team-Schulungen
- Knowledge Sharing Sessions

---

## 📝 TEMPLATE-NUTZUNG

### Für neues Projekt:
1. Dieses Template kopieren
2. Projektspezifische Informationen eintragen
3. Nicht benötigte Sektionen entfernen
4. Projektspezifische Sektionen hinzufügen
5. Status-Report initialisieren
6. Git Repository erstellen
7. Erste Dokumentation committen

---

## 📚 WAS NICHT ENTHALTEN IST

### Bei Bedarf selbst ergänzen:
```
❌ Framework-spezifische Guides (Laravel, React, Vue, etc.)
❌ Cloud-Provider Deployments (AWS, Azure, GCP)
❌ Container-Orchestration (Kubernetes, Docker Swarm)
❌ CI/CD-Pipeline Configs (Jenkins, GitLab CI, GitHub Actions)
❌ Monitoring Tools (Prometheus, Grafana, ELK Stack)
❌ Microservices-Architektur Patterns
❌ Domain-spezifisches Business-Wissen
❌ Client-Management Prozesse
❌ Team-Collaboration Tools (Jira, Confluence)
❌ Agile/Scrum Ceremonies
❌ Mobile Development (iOS, Android)
❌ Data Science & ML Workflows
❌ Blockchain-Entwicklung
```

---

## 🔗 EXTERNE RESSOURCEN

### Programming & Development:
**PHP:**
- Docs: https://www.php.net/docs.php
- PHP The Right Way: https://phptherightway.com/
- PSR Standards: https://www.php-fig.org/psr/

**JavaScript:**
- MDN Web Docs: https://developer.mozilla.org/en-US/docs/Web/JavaScript
- JavaScript.info: https://javascript.info/

**Python:**
- Docs: https://docs.python.org/3/

### Database:
**SQLite:**
- Docs: https://www.sqlite.org/docs.html
- Tutorial: https://www.sqlitetutorial.net/

**MySQL/MariaDB:**
- MySQL: https://dev.mysql.com/doc/
- MariaDB: https://mariadb.com/kb/en/

### Version Control:
**Git:**
- Pro Git Book: https://git-scm.com/book/en/v2
- GitHub Guides: https://guides.github.com/
- Conventional Commits: https://www.conventionalcommits.org/
- Semantic Versioning: https://semver.org/

### Testing:
**PHP Testing:**
- PHPUnit: https://phpunit.de/
- Pest PHP: https://pestphp.com/

**Load Testing:**
- Apache JMeter: https://jmeter.apache.org/
- k6: https://k6.io/

### Security:
**OWASP:**
- Top 10: https://owasp.org/www-project-top-ten/
- Testing Guide: https://owasp.org/www-project-web-security-testing-guide/
- Cheat Sheets: https://cheatsheetseries.owasp.org/

**Tools:**
- OWASP ZAP: https://www.zaproxy.org/
- Snyk: https://snyk.io/

### DevOps & Deployment:
**Docker:**
- Docs: https://docs.docker.com/

**CI/CD:**
- GitHub Actions: https://docs.github.com/en/actions
- GitLab CI: https://docs.gitlab.com/ee/ci/

### AI & Machine Learning:
**Ollama:**
- Docs: https://ollama.ai/
- Models: https://ollama.ai/library

**OpenAI:**
- API Docs: https://platform.openai.com/docs

### Frameworks:
**Backend:**
- Laravel (PHP): https://laravel.com/docs
- Express.js: https://expressjs.com/

**Frontend:**
- React: https://react.dev/
- Vue.js: https://vuejs.org/
- Tailwind CSS: https://tailwindcss.com/docs

### Performance:
- PageSpeed Insights: https://pagespeed.web.dev/
- web.dev: https://web.dev/

### Code Quality:
- ESLint: https://eslint.org/
- Prettier: https://prettier.io/

### Learning:
- freeCodeCamp: https://www.freecodecamp.org/
- MDN Learning: https://developer.mozilla.org/en-US/docs/Learn

### Communities:
- Stack Overflow: https://stackoverflow.com/
- Dev.to: https://dev.to/
- Reddit r/programming: https://www.reddit.com/r/programming/

### Austrian Economics & Bitcoin:
**Austrian Economics:**
- Mises Institute: https://mises.org/
- FEE: https://fee.org/

**Bitcoin:**
- Bitcoin.org: https://bitcoin.org/
- Learn Me A Bitcoin: https://learnmeabitcoin.com/
- Mastering Bitcoin: https://github.com/bitcoinbook/bitcoinbook

---

**Template Version:** 1.2
**Basiert auf:** sgiT Education Platform Erfahrungen
**Erstellt am:** 2024-12-01
**Letzte Aktualisierung:** 2025-12-08 (Docker, AI, Backup, Env erweitert)
**Maintained by:** deStevie / sgiT Solution Engineering

═══════════════════════════════════════════════════
