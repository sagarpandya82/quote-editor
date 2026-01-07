# Quote Editor

A Ruby on Rails 7 application built with **Hotwire** (Turbo + Stimulus) and a
server-driven UI.  
This project follows the Hotwire/Turbo Rails tutorial and is fully containerised
for local development.


> https://www.hotrails.dev/turbo-rails


## Tech Stack

- Ruby **3.0.6**
- Rails **7.0.x**
- Hotwire (Turbo, Stimulus)
- PostgreSQL
- Node **18** (esbuild, Sass)
- Docker & Docker Compose

## Prerequisites

You only need:

- Docker
- Docker Compose

No local Ruby, Node, or Postgres installation is required.

## Getting Started

Clone the repository and start the app:

```bash
git clone <repo-url>
cd quote-editor
docker compose up
```

On first run, prepare the database:

```shell
docker compose run --rm web bin/rails db:prepare
```

Seed data:

```shell
docker compose exec web bin/rails db:seed
```

Run tests:

```shell
docker compose exec web bin/rails test:system
```

Then visit:

```shell
http://localhost:3000
```