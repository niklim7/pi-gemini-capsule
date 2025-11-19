Station SV1SYY: Self-Hosted Sovereign Node

    A permacomputing project repurposing legacy hardware into a dual-protocol (Gemini + Web) communication node.



Product Vision

In an era of disposable technology and bloated web frameworks, this project aims to prove that "obsolete" hardware can still serve a critical role in a modern network.

The Goal: To build a sovereign, privacy-focused communication platform hosted entirely on a salvaged Raspberry Pi 3B, bridging the gap between the minimalist Gemini Protocol and the standard World Wide Web.

Technical Architecture

This system runs on a headless Raspberry Pi OS Lite environment, utilizing a micro-services approach to handle different network protocols simultaneously.
Component	Technology	Purpose
Hardware	Raspberry Pi 3B	Salvaged board in a custom Kintaro SNES case.
DNS / Ads	Pi-hole	Network-wide ad blocking and local DNS resolution.
Gemini Server	Jetforce (Python)	Serves native .gmi content on Port 1965.
Web Mirror	Python (Flask)	Custom middleware that transpiles Gemtext to HTML on the fly.
Security	OpenSSL / Let's Encrypt	Dual-stack SSL management (Self-signed & CA-signed).
Backup	Bash / Rsync	Automated daily incremental backups to cold storage (USB).

The "Pivot": Agile Problem Solving

A note on the development process:

Initially, the project architecture selected Agate (Rust-based) for the server daemon. However, during the deployment sprint, we encountered a critical binary incompatibility with the specific ARMv8 architecture of the legacy Pi 3B, causing repeated SIGABRT failures.

Rather than spending excessive resources debugging a compiled binary "black box," I made the decision to pivot the tech stack. We migrated to Jetforce, a Python-based server.

    Result: Immediate stability, easier maintenance via pip, and native integration with the Python-based Web Mirror script.

    Trade-off: Slightly higher memory usage for vastly improved maintainability and development velocity.

Key Features

1. The Gemini Capsule (gemini://sv1syy.radio)

A lightweight, text-first capsule documenting Amateur Radio (Ham) activities.

    Hosted via Jetforce.

    Secured via manually generated OpenSSL certificates (10-year validity).

    Accessible via low-bandwidth clients (Lagrange, Kristall).

2. The Read-Only Web Mirror (https://www.sv1syy.radio)

To ensure accessibility for users without Gemini clients, I developed a custom Python Middleware (web_mirror.py).

    Function: Intercepts HTTP requests on Port 8080.

    Transpilation: Parses .gmi files and renders them as semantic HTML5 in real-time.

    Styling: Injects a custom Dark Mode / Retro Terminal CSS theme.

    ASCII Art Engine: Features a custom logic block to preserve spacing in ASCII art headers while ensuring mobile responsiveness.

3. Automated Disaster Recovery

Data integrity is managed via a custom Bash script (daily_backup.sh) running on a Cron schedule.

    Strategy: Daily incremental sync using rsync.

    Target: Locally mounted 32GB USB drive (ext4).

    Scope: Backs up the entire filesystem (excluding virtual dirs /proc, /sys) to allow for bare-metal restoration if the SD card fails.

Code Snippets

The Web Mirror Logic

The core transpiler uses Flask to route requests and map Gemtext elements to HTML tags.
Python

# Snippet from web_mirror.py
def gmi_to_html(gmi_text):
    # ... logic to parse lines ...
    if line.startswith("=>"):
        # Auto-detects links vs images
        if url.endswith(('.jpg', '.png')):
             html_output.append(f'<figure><img src="{url}"...>')
        else:
             html_output.append(f'<a href="{url}"...>')

(Full source code available in the repository)

License

This project adopts a dual-license model to support the Free Culture movement:

    Content: Creative Commons Attribution-ShareAlike 4.0 (CC BY-SA 4.0)

    Code: GNU General Public License v3 (GPLv3)

73 de Nik SV1SYY
