# 42 Inception

This project is part of the **42 School curriculum**.  
It aims to introduce system administration concepts using **Docker** and **docker compose**, by setting up a multi-container infrastructure from scratch.

---

## Project Overview

The goal of **Inception** Projext is to create and configure a small infrastructure composed of several Docker containers, each running a different service.  
All containers are built **from scratch using custom Dockerfiles** (no prebuilt images like `mariadb` or `nginx` etc ...).

### Services:

| Service     | Description |
|--------------|-------------|
| **Nginx**    | Web server acting as a reverse proxy for WordPress (TLS-enabled). |
| **WordPress** | Runs PHP-FPM and serves the WordPress site. |
| **MariaDB**  | Database service storing WordPress data. |
| **Adminer** *(bonus)* | Lightweight web-based database management tool. |
| **cAdvisor** *(bonus)* | Monitoring tool for containers and system metrics. |

---

## Repository Structure
```bash
42_inception
├── Makefile
├── README.md
└── srcs
    ├── docker-compose.yml
    ├── .env                # Environment file (contains your credentials)
    └── requirements
        ├── bonus
        │   ├── adminer
        │   │   └── Dockerfile
        │   └── cAdvisor
        │       └── Dockerfile
        ├── mariadb
        │   ├── Dockerfile
        │   └── init_db.sh
        ├── nginx
        │   ├── Dockerfile
        │   └── tools
        │       ├── index.html
        │       └── nginx.conf
        └── wordpress
            ├── Dockerfile
            ├── init_wp.sh
            └── www.conf
```
## 🚀 How to Run

Make sure Docker and docker compose are installed, then simply run:

```bash
make
```

For more info run:
```bash
make help
```

## Notes

- Your environment variables are expected to be in .env under srcs/.
- Data is persisted inside /home/your_home/data/ (bind-mounted volumes), you can change it in docker-compose.yml.
