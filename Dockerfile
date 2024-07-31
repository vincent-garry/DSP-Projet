FROM openjdk:11-jre-slim

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y \
    xvfb \
    x11vnc \
    novnc \
    supervisor \
    fluxbox \
    libxrender1 \
    libxtst6 \
    libxi6 \
    fontconfig \
    libfreetype6 \
    fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY target/Jeu_Puissance4-1.0-SNAPSHOT.jar /app/Jeu_Puissance4.jar

# Configuration de supervisord
COPY <<EOF /etc/supervisor/conf.d/supervisord.conf
[supervisord]
nodaemon=true

[program:xvfb]
command=/usr/bin/Xvfb :99 -screen 0 1024x768x16
autorestart=true

[program:x11vnc]
command=/usr/bin/x11vnc -display :99 -forever -shared
autorestart=true

[program:novnc]
command=/usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 8080
autorestart=true

[program:fluxbox]
command=/usr/bin/fluxbox
autorestart=true

[program:java]
command=java -jar /app/Jeu_Puissance4.jar
autorestart=true
environment=DISPLAY=:99
EOF

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]