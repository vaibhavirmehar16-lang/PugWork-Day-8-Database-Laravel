# Laravel API Source Files

This directory contains the application-specific source files for a Laravel 12 REST API. It does not contain Laravel's framework/vendor dependencies.

## Install
Create a fresh Laravel 12 application in this directory (or create it elsewhere and copy these source files into it):
```bat
composer create-project laravel/laravel facility-api "^12.0"
cd facility-api
php artisan install:api
```
Copy this directory's `app/`, `routes/api.php`, and `database/migrations/` into the generated project, merging files if prompted. Configure the MySQL `.env`, then run:
```bat
php artisan key:generate
php artisan migrate
php artisan serve
```

If you run the SQL schema instead, do not also run these migrations against the same database.

## Source inventory
- `app/Models`: Facility, Inspection, Complaint, User, Employee
- `app/Http/Requests`: validated create/update inputs
- `app/Http/Controllers/Api`: CRUD endpoints with JSON responses
- `database/migrations`: schema definition
- `routes/api.php`: resource API routes
