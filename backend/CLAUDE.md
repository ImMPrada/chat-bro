# Chat-Bro Backend

Rails 7.2.2 API-only application for the Chat-Bro project.

## Architecture

### Tech Stack
- **Rails**: 7.2.2 (API-only mode)
- **Ruby**: 3.3.0
- **Database**: MySQL
- **Authentication**: OAuth2 (via Doorkeeper in UsersEngine)
- **Background Jobs**: Delayed Job
- **API Format**: JSON (Jbuilder)

### Mounted Engines

The application uses a modular engine-based architecture with the following engines from `bro-garden-on-rails`:

1. **UsersEngine** (`/users_engine`)
   - User management
   - OAuth2 authentication (passwordless: OTP/magic links)
   - Roles and features (RBAC)
   - Token expiration: 1 month

2. **PersonasEngine** (`/personas_engine`)
   - Companies management
   - People management
   - Work positions

3. **Stakes** (shared library)
   - Common utilities (Uuidable, Colorable, etc.)

## Project Structure

```
backend/
├── app/                    # Rails app (minimal, most logic in engines)
├── bin/                    # Executable scripts
│   └── setup              # Setup script for fresh installations
├── config/                 # Configuration files
│   ├── initializers/
│   │   ├── cors.rb        # CORS for Next.js frontend
│   │   ├── bullet.rb      # N+1 query detection
│   │   └── users_engine.rb # OAuth token configuration
│   ├── application.rb     # Rails app configuration
│   ├── database.yml       # MySQL configuration
│   └── routes.rb          # Engine mounting
├── data/                   # Reference data (YAML)
│   ├── roles.yml          # User roles and feature permissions
│   ├── work_positions.yml # Job positions with regex patterns
│   └── README.md          # Data directory documentation
├── db/
│   ├── migrate/           # Migrations (from engines)
│   ├── seeds.rb           # Database seeding (loads from data/)
│   └── schema.rb          # Database schema
└── .env                    # Environment variables (not in git)
```

## Setup

### Prerequisites
- MySQL installed and running
- rbenv with Ruby 3.3.0
- Access to bro-garden-on-rails engines at:
  `/Users/immprada/projects/nebula-project/bro-garden-on-rails/`

### Fresh Installation

```bash
# Run the setup script
./bin/setup

# Or manually:
bundle install
rails db:create
rails db:migrate
rails db:seed
```

### Start Server

```bash
rails s -p 3001
```

The server runs on `http://localhost:3001`

## Environment Variables

Create a `.env` file with:

```bash
# Database
DATABASE_USERNAME=root
DATABASE_PASSWORD=
DATABASE_HOST=localhost
DB_POOL=5

# Frontend
FRONTEND_URL=http://localhost:3000

# Rails
RAILS_ENV=development
```

## Database Seeding

Seeds are loaded from YAML files in the `data/` directory:

- **Roles**: User roles with feature permissions
- **Work Positions**: Job titles with regex matching patterns
- **OAuth App**: Frontend OAuth application credentials
- **Test User**: `test@chatbro.com` (passwordless auth)

Run seeds:
```bash
rails db:seed        # Safe to run multiple times
rails db:reset       # Drop, create, migrate, and seed
```

## Authentication

UsersEngine uses **passwordless authentication**:
- OTP (One-Time Password)
- Magic Links
- Verification Codes

### OAuth Flow

1. Client requests authentication via strategy (OTP/magic link)
2. User receives code/link
3. User verifies and receives OAuth access token
4. Token expires in 1 month (configurable in `config/initializers/users_engine.rb`)

### OAuth Credentials

OAuth application credentials are displayed during seeding. Store them securely for frontend configuration.

## API Endpoints

### Health Check
```
GET /up
```

### UsersEngine
```
POST   /users_engine/v1/auth/token         # OAuth token
POST   /users_engine/v1/otp/magic_links    # Request magic link
POST   /users_engine/v1/otp/verification_codes # Request OTP
GET    /users_engine/v1/auth/me            # Current user
GET    /users_engine/v1/users              # List users
```

### PersonasEngine
```
GET    /personas_engine/v1/companies       # List companies
POST   /personas_engine/v1/companies       # Create company
GET    /personas_engine/v1/people          # List people
GET    /personas_engine/v1/work_positions  # List work positions
```

## CORS Configuration

CORS is enabled for the Next.js frontend running on `http://localhost:3000` (configurable via `FRONTEND_URL` env var).

All methods allowed: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD

## Development Tools

- **Bullet**: N+1 query detection (enabled in development)
- **Brakeman**: Security vulnerability scanning
- **Bundle Audit**: Gem vulnerability scanning

## Common Tasks

### Check Routes
```bash
rails routes
rails routes | grep engine_name
```

### Database Status
```bash
rails db:migrate:status
```

### Console
```bash
rails console
```

### Run Migrations
```bash
rails db:migrate
```

### Reset Database
```bash
rails db:reset
```

## Phase 1 Implementation Summary

✅ Rails 7.2.2 API-only application created
✅ MySQL database configured
✅ Two engines mounted (users, personas)
✅ OAuth2 authentication configured (1-month tokens)
✅ CORS enabled for Next.js frontend
✅ Database seeded with reference data from YAML files
✅ Setup script created for easy installation
✅ All endpoints tested and accessible

## Next Steps

- **Phase 2**: Create ChatEngine for conversation and message management
- **Phase 3**: Implement real-time features with ActionCable and Redis

## Troubleshooting

### MySQL Connection Issues
- Check MySQL is running: `mysql.server status`
- Verify credentials in `.env`
- Check database exists: `rails db:create`

### Engine Loading Issues
- Verify engine paths in `Gemfile`
- Run `bundle install`
- Check mounted routes: `rails routes`

### Migration Issues
- Check migration version matches Rails version (7.2)
- Fix with: `find db/migrate -name "*.rb" -exec sed -i '' 's/8\.0/7.2/g' {} \;`

## Notes

- OAuth credentials change on each `db:reset` - update frontend config accordingly
- UsersEngine does NOT use password authentication
- All reference data is managed through `data/*.yml` files
- Engines are mounted from local paths (development only)
