# Day 8 — Database + Laravel
## Facility Inspection & Complaint Management API

**Training:** 10-Day Intern Technical Training & Domain Assessment Program  
**Day:** 08 — Database + Laravel  
**Stack:** MySQL 8+, PHP 8.2+, Laravel 12, Eloquent ORM, REST/JSON API

## Project overview
A relational database and REST API for managing departments, employees, facilities, inspections, and complaints. The project demonstrates relational schema design, keys and constraints, SQL querying, indexes, transactions, Laravel migrations, Eloquent relationships, request validation, and CRUD API design.

## Repository structure
```text
day-08/
├── sql/
│   ├── 01_schema.sql
│   ├── 02_seed_data.sql
│   ├── 03_queries.sql
│   └── 04_transactions.sql
├── database/
│   ├── ER_DIAGRAM.md
│   └── DATA_DICTIONARY.md
├── laravel-api/
│   ├── README.md
│   ├── routes/api.php
│   ├── app/Models/
│   ├── app/Http/Controllers/Api/
│   ├── app/Http/Requests/
│   └── database/migrations/
└── README.md
```

## Database setup (MySQL)
1. Open MySQL Workbench or a MySQL client.
2. Run `sql/01_schema.sql`.
3. Run `sql/02_seed_data.sql`.
4. Run the examples in `sql/03_queries.sql`.
5. Review safe transaction examples in `sql/04_transactions.sql`.

The SQL schema creates a database named `day8_facility_management`. If you prefer another name, update the database name in the first SQL file and the Laravel `.env` settings.

## Laravel setup
This ZIP contains the Laravel application source files and migrations to integrate into a fresh Laravel 12 project. A full framework `vendor/` directory is intentionally not included.

Requirements: PHP 8.2+, Composer, and MySQL 8+.

```bat
cd day-08
cd laravel-api
composer create-project laravel/laravel . "^12.0"
```

> If Composer says the directory is not empty, create the Laravel project in a temporary folder first, then copy the provided `app`, `routes/api.php`, and `database/migrations` files into it. Keep Laravel's generated framework files.

Configure `.env`:
```dotenv
APP_NAME="Day 8 Facility API"
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://127.0.0.1:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=day8_facility_management
DB_USERNAME=root
DB_PASSWORD=
```

Then run:
```bat
php artisan key:generate
php artisan install:api
php artisan migrate
php artisan serve
```

`php artisan install:api` creates the API routing setup for a fresh Laravel 12 project. If `routes/api.php` already exists, preserve the supplied route definitions and do not overwrite them. For a Laravel project created with API routing already enabled, simply ensure `routes/api.php` is registered in `bootstrap/app.php`.

### Important database note
The SQL scripts and Laravel migrations describe the same logical entities. Use **either** the SQL schema script **or** Laravel migrations to create the tables in a given database, not both, because both create the same tables.

## API endpoints
Base URL: `http://127.0.0.1:8000/api`

| Method | Endpoint | Description |
|---|---|---|
| GET | `/facilities` | List facilities (optional `?search=`, `?per_page=`) |
| POST | `/facilities` | Create a facility |
| GET | `/facilities/{id}` | Facility details and latest inspections |
| PUT/PATCH | `/facilities/{id}` | Update a facility |
| DELETE | `/facilities/{id}` | Delete a facility |
| GET/POST | `/inspections` | List/create inspections |
| GET | `/inspections/{id}` | Inspection details |
| PUT/PATCH | `/inspections/{id}` | Update an inspection |
| DELETE | `/inspections/{id}` | Delete an inspection |
| GET/POST | `/complaints` | List/create complaints |
| GET | `/complaints/{id}` | Complaint details |
| PUT/PATCH | `/complaints/{id}` | Update a complaint |
| DELETE | `/complaints/{id}` | Delete a complaint |

All successful responses are JSON. Validation failures return Laravel's standard `422 Unprocessable Entity` JSON response. Missing resources return `404 Not Found`.

## Example requests

Create a facility:
```bash
curl -X POST http://127.0.0.1:8000/api/facilities \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"name":"Central Library","location":"North Zone","cleanliness_score":8.5,"status":"active"}'
```

Create an inspection:
```bash
curl -X POST http://127.0.0.1:8000/api/inspections \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"facility_id":1,"inspector_id":1,"inspection_date":"2026-10-20","cleanliness_score":7.5,"odor_score":2,"waste_level":"medium","notes":"Bins emptied; floor requires attention."}'
```

Create a complaint:
```bash
curl -X POST http://127.0.0.1:8000/api/complaints \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"facility_id":1,"user_id":1,"title":"Overflowing waste bin","description":"The bin near the entrance is full.","priority":"medium","status":"open"}'
```

## Architecture flow
`Request → Route → Controller → Form Request validation → Eloquent Model → Database → JSON Response`

- **Route:** maps an HTTP method and URI to an action.
- **Controller:** coordinates the operation and returns a response.
- **Form Request:** validates and authorizes incoming input.
- **Model / Eloquent:** maps a PHP class to a database table and defines relationships.
- **Migration:** version-controls the schema.
- **Middleware:** can apply cross-cutting checks; Laravel's API middleware and authentication can protect routes.
- **Response:** consistent JSON payload and suitable HTTP status code.

## Security and engineering notes
- Never commit `.env`, real credentials, API keys, or production database passwords.
- For production, enable authentication (Laravel Sanctum), authorization policies, rate limiting, logging, and HTTPS.
- The supplied CRUD endpoints are intentionally public for local training/testing. Do not deploy publicly without adding authentication/authorization.
- Validate every write operation and rely on foreign keys for referential integrity.
- Pagination is enabled on list endpoints to avoid returning unbounded datasets.

## Deliverable checklist
- [x] Six related tables with primary/foreign keys
- [x] SQL CRUD/reporting examples, joins, subquery, grouping, index, transactions
- [x] Laravel API source: models, migrations, form requests, controllers, routes
- [x] Facility, inspection, and complaint CRUD
- [x] Setup instructions and sample API payloads
- [ ] Run locally with your own PHP/MySQL setup and capture real screenshots
- [ ] Push to your own GitHub repository

## GitHub submission
From the parent directory that contains `day-08`, run:
```bat
git init
git add day-08
git commit -m "Complete Day 8 database and Laravel API assignment"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
git push -u origin main
```
Replace the URL with your own repository URL. If the folder is already inside an existing Git repository, do not run `git init`; add and commit only the `day-08` folder instead.
