# Data Dictionary

| Table | Purpose | Important constraints |
|---|---|---|
| users | Login identity / complaint submitter | Unique email; password hash only |
| departments | Organization units | Unique department name |
| employees | Staff and salary records | Unique employee code; department FK; non-negative salary |
| facilities | Managed physical facilities | Cleanliness score 0–10; status enum |
| inspections | Dated inspections and observations | Facility and inspector FKs; cleanliness 0–10; odor 1–5 |
| complaints | Reported issues and workflow status | Facility and user FKs; priority and status enums |

## Design choices
- `BIGINT UNSIGNED` identifiers align with Laravel's `id()` / `foreignId()` conventions.
- `DECIMAL` is used for salary and scores instead of floating-point storage.
- Foreign keys enforce referential integrity.
- Composite indexes support common department/salary, facility/date, and complaint-status lookups.
- `created_at` and `updated_at` support audit-friendly timestamps.
- Example seed passwords are nonfunctional placeholders and must never be used as real credentials.
