# Inception Project 🚀

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/docker--compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-%23117AC9.svg?style=for-the-badge&logo=WordPress&logoColor=white)

A project focused on system administration and containerization using Docker. This setup deploys a simple infrastructure composed of NGINX, WordPress, and MariaDB services, each running in its own container, all orchestrated by Docker Compose.

## Table of Contents
- [Project Architecture](#project-architecture)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Usage](#usage)
- [Services](#services)
- [Environment Variables](#environment-variables)
- [Data Persistence](#data-persistence)

---

## Project Architecture

This project uses a multi-container architecture orchestrated by `docker-compose`.



1.  **NGINX**: Acts as the web server and reverse proxy. It listens on port 443 and serves the static content. All traffic to the WordPress site is routed through this container. It is configured with TLS/SSL for secure `HTTPS` connections.
2.  **WordPress**: The application service. It runs the WordPress CMS, built on a PHP-FPM image. It communicates with the MariaDB container to store and retrieve data. It does not expose any ports to the host machine directly; all traffic is managed by NGINX.
3.  **MariaDB**: The database service. It runs a MariaDB server to provide a persistent SQL database for the WordPress application.

---

## Prerequisites

Before you begin, ensure you have the following installed on your system:
* **Docker**: [Get Docker](https://docs.docker.com/get-docker/)
* **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)

---

## Installation & Setup

Follow these steps to get your project up and running.

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/](https://github.com/)<your-username>/inception.git
    cd inception
    ```

2.  **Configure your domain:**
    You must add your domain to your host's `/etc/hosts` file to resolve it locally.
    ```bash
    sudo vim /etc/hosts
    ```
    Add the following line at the end of the file:
    ```
    127.0.0.1 <your-domain>.com
    ```
    Replace `<your-domain>.com` with the domain you set in your `.env` file (e.g., `johndoe.42.fr`).

3.  **Create the Environment File:**
    Create a `.env` file in the root directory of the project. This file will store all your sensitive credentials and configuration variables. **Do not commit this file to version control.**
    ```bash
    touch .env
    ```
    Populate it with the necessary variables. See the [Environment Variables](#environment-variables) section for a complete list.

4.  **Build and run the containers:**
    From the root directory, run the following command. The `-d` flag runs the containers in detached mode.
    ```bash
    docker-compose up --build -d
    ```

5.  **Access your WordPress site:**
    Open your favorite web browser and navigate to `https://<your-domain>.com`. You should be greeted by the WordPress installation page.

---

## Usage

Here are some common Docker Compose commands to manage your services:

* **Start the services:**
    ```bash
    docker-compose up -d
    ```

* **Stop the services:**
    ```bash
    docker-compose down
    ```

* **View logs for all services:**
    ```bash
    docker-compose logs -f
    ```

* **View logs for a specific service (e.g., wordpress):**
    ```bash
    docker-compose logs -f wordpress
    ```

* **Remove all containers, networks, and volumes:**
    ```bash
    docker-compose down --volumes
    ```

---

## Services

### NGINX
* **Image**: Based on the official Debian image.
* **Configuration**: Configured to use TLSv1.3 with a self-signed SSL certificate.
* **Role**: Serves as a reverse proxy, forwarding PHP requests to the WordPress container on port 9000. It handles all `HTTPS` traffic on port `443`.

### WordPress
* **Image**: Based on the official `wordpress:php7.4-fpm` image.
* **Configuration**: Connects to the MariaDB container using the credentials specified in the `.env` file. The `wp-config.php` file is configured to read these environment variables.
* **Role**: Runs the WordPress application logic.

### MariaDB
* **Image**: Based on the official `mariadb` image.
* **Configuration**: The database, user, and passwords are initialized based on the `.env` variables.
* **Role**: Provides a persistent SQL database for WordPress.

---

## Environment Variables

Create a `.env` file in the project's root with the following variables. Replace the placeholder values with your own secure credentials.

```env
# Domain Name
DOMAIN_NAME=yourdomain.com

# SSL Certificate Details
SSL_COUNTRY=MA
SSL_STATE=Safi
SSL_CITY=BenGuerir
SSL_ORG=1337
SSL_UNIT=student

# MariaDB Credentials
DB_NAME=wordpress_db
DB_USER=wp_user
DB_PASSWORD=strong_password
DB_ROOT_PASSWORD=super_strong_root_password

# WordPress Admin Credentials (for initial setup)
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@yourdomain.com
```

---

## Data Persistence

To ensure data is not lost when containers are stopped or removed, this project uses **Docker volumes**.

* `db_data`: A volume that stores all MariaDB database files.
* `wp_data`: A volume that stores all WordPress files (themes, plugins, uploads).

These volumes are managed by Docker and are created automatically when you first run `docker-compose up`.

---
