# Entity Relationship Diagram

```mermaid
erDiagram
    USERS ||--o| EMPLOYEES : "optional profile"
    DEPARTMENTS ||--o{ EMPLOYEES : contains
    EMPLOYEES ||--o{ INSPECTIONS : performs
    FACILITIES ||--o{ INSPECTIONS : receives
    USERS ||--o{ COMPLAINTS : submits
    FACILITIES ||--o{ COMPLAINTS : receives

    USERS {
        bigint id PK
        varchar name
        varchar email UK
        varchar password
        enum role
    }
    DEPARTMENTS {
        bigint id PK
        varchar name UK
        varchar location
    }
    EMPLOYEES {
        bigint id PK
        bigint user_id FK
        bigint department_id FK
        varchar employee_code UK
        decimal salary
    }
    FACILITIES {
        bigint id PK
        varchar name
        varchar location
        decimal cleanliness_score
        enum status
    }
    INSPECTIONS {
        bigint id PK
        bigint facility_id FK
        bigint inspector_id FK
        date inspection_date
        decimal cleanliness_score
        enum waste_level
    }
    COMPLAINTS {
        bigint id PK
        bigint facility_id FK
        bigint user_id FK
        varchar title
        enum priority
        enum status
    }
```

## Relationship explanation
- A department has many employees; each employee belongs to one department.
- A user can optionally have one employee profile; an employee profile can reference one user.
- A facility has many inspections; each inspection belongs to one facility.
- An employee can perform many inspections; each inspection has one inspector.
- A facility has many complaints; each complaint belongs to one facility.
- A user can submit many complaints; each complaint has one submitting user.
