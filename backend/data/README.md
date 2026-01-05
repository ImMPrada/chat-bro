# Data Directory

This directory contains YAML files with reference and seed data for the Chat-Bro backend application.

## Purpose

The YAML files in this directory provide:
- **Maintainability**: Easy-to-edit reference data without touching Ruby code
- **Version Control**: Track changes to reference data over time
- **Consistency**: Single source of truth for lookup tables across environments
- **Documentation**: Self-documenting structure for roles, features, and other reference data

## Files

### `roles.yml`
Defines user roles and their feature permissions using feature patterns.

**Structure:**
```yaml
- code: nivel_1
  feature_patterns:
    - users_engine
    - personas_engine
    - chat_engine
```

### `work_positions.yml`
Defines work positions (job titles) with regex patterns for automatic matching.

**Structure:**
```yaml
- code: admin
  title_matches:
    - gerente\s+administrativ(o|a)
    - coordinadora?\s+administrativ(o|a)
```

## Usage

The data files are automatically loaded during `rails db:seed`. To reload:

```bash
rails db:reset  # Drops, creates, migrates, and seeds
# OR
rails db:seed   # Just runs seeds (won't duplicate data due to find_or_create_by)
```

## Adding New Data

1. Edit the appropriate YAML file
2. Run `rails db:seed` to load the new data
3. Commit the changes to version control

## Notes

- The seed script uses `find_or_create_by!` so running seeds multiple times is safe
- Changes to existing records (like updating a color) require a migration or manual update
- For bulk updates, consider creating a rake task instead of modifying seeds directly
