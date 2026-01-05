# Chat-Bro Backend

Rails 7.2.2 API-only backend for the Chat-Bro project - a modern chat application with AI integration capabilities.

## Overview

This backend uses a modular engine-based architecture, mounting pre-built engines from [bro-garden-on-rails](https://github.com/bro-garden/bro-garden-on-rails) for user management and personas functionality.

### Tech Stack

- **Ruby**: 3.3.0
- **Rails**: 7.2.2 (API-only)
- **Database**: MySQL
- **Authentication**: OAuth2 via Doorkeeper (passwordless)
- **Background Jobs**: Delayed Job
- **API Format**: JSON (Jbuilder)

## Quick Start

### Prerequisites

- Ruby 3.3.0 (via rbenv)
- MySQL 8.0+
- Bundler 2.0+

### Installation

```bash
# Clone the repository
cd backend

# Run setup script (installs dependencies, creates DB, runs migrations and seeds)
./bin/setup

# Start the server
rails s -p 3001
```

The API will be available at `http://localhost:3001`

## Architecture

### Mounted Engines

| Engine | Mount Path | Purpose |
|--------|------------|---------|
| **UsersEngine** | `/users_engine` | User management, OAuth2 authentication, roles & features |
| **PersonasEngine** | `/personas_engine` | Companies, people, and work positions |

All engines are sourced from `bro-garden-on-rails` via local path dependencies.

### Key Features

- **Passwordless Authentication**: OTP and magic link support via UsersEngine
- **Role-Based Access Control**: Flexible roles with feature permissions
- **CORS Enabled**: Configured for Next.js frontend at `localhost:3000`
- **YAML-Driven Data**: Reference data managed through `data/*.yml` files
- **N+1 Detection**: Bullet gem for query optimization

## Configuration

### Environment Variables

Create a `.env` file in the backend directory:

```bash
# Database
DATABASE_USERNAME=root
DATABASE_PASSWORD=
DATABASE_HOST=localhost
DB_POOL=5

# Frontend CORS
FRONTEND_URL=http://localhost:3000

# Rails
RAILS_ENV=development
```

### OAuth Setup

OAuth credentials are generated during `rails db:seed`. You'll need these for the frontend:

```bash
rails db:seed
# Look for "Client ID" and "Client Secret" in the output
```

## API Endpoints

### Health Check
```
GET /up
```

### Authentication (UsersEngine)
```
POST /users_engine/v1/auth/token              # Get OAuth token
POST /users_engine/v1/otp/magic_links         # Request magic link
POST /users_engine/v1/otp/verification_codes  # Request OTP code
GET  /users_engine/v1/auth/me                 # Current user info
```

### Users (UsersEngine)
```
GET  /users_engine/v1/users                   # List users
POST /users_engine/v1/users                   # Create user
```

### Companies (PersonasEngine)
```
GET  /personas_engine/v1/companies            # List companies
POST /personas_engine/v1/companies            # Create company
```

See full route list: `rails routes`

## Database

### Schema

The database includes tables from all mounted engines:
- Users, roles, features (UsersEngine)
- OAuth applications and tokens (Doorkeeper)
- Companies, people, work positions (PersonasEngine)

### Migrations

```bash
# Run migrations
rails db:migrate

# Check migration status
rails db:migrate:status

# Rollback
rails db:rollback
```

### Seeding

Seeds load data from YAML files in `data/`:

```bash
# Run seeds (safe to run multiple times)
rails db:seed

# Reset database (drop, create, migrate, seed)
rails db:reset
```

#### Reference Data Files

- `data/roles.yml` - User roles and feature permissions
- `data/work_positions.yml` - Job positions with regex patterns

## Development

### Console

```bash
rails console
```

### Running Tests

```bash
# Tests not yet implemented (Phase 1)
# Will be added in future phases
```

### Code Quality

```bash
# Security scan
bin/brakeman

# Dependency audit
bin/bundler-audit

# Linting
bin/rubocop
```

### Debugging

- **Bullet**: N+1 query detection enabled in development
- **Logs**: Check `log/development.log`

## Common Tasks

### Update Engine Migrations

```bash
rails users_engine:install:migrations
rails personas_engine:install:migrations
rails db:migrate
```

### Create New User

```bash
rails console

# Create user
user = UsersEngine::User.create!(
  email: "newuser@example.com",
  role: UsersEngine::Role.find_by(code: "nivel_1"),
  status: :active
)
```

### Generate OAuth Token (for testing)

Since the app uses passwordless auth, you'll need to use the OTP/magic link flow. For testing, you can create tokens directly in console:

```ruby
user = UsersEngine::User.find_by(email: "test@chatbro.com")
app = Doorkeeper::Application.first

token = Doorkeeper::AccessToken.create!(
  resource_owner_id: user.id,
  application_id: app.id,
  scopes: "public",
  expires_in: 1.month
)

puts "Token: #{token.token}"
```

## Rake Tasks from Engines

The mounted engines provide useful rake tasks for managing data and configurations.

### UsersEngine Tasks

#### OAuth Applications
```bash
# List all OAuth applications
rake users_engine:applications:list

# Create new OAuth application
rake users_engine:applications:create[name,redirect_uri]
# Example: rake users_engine:applications:create["Mobile App","myapp://oauth/callback"]

# Delete OAuth application
rake users_engine:applications:delete[uid]
```

#### Roles Management
```bash
# List all roles
rake users_engine:roles:list

# Create roles from YAML file
rake users_engine:roles:create[yaml_path]
# Example: rake users_engine:roles:create[data/roles.yml]

# Assign role to user
rake users_engine:roles:assign_to_user[email,role_code]
# Example: rake users_engine:roles:assign_to_user[user@example.com,nivel_1]
```

#### Features Management
```bash
# List all features
rake users_engine:features:list

# Create features for all engines
rake users_engine:features:create
```

#### User Management
```bash
# Activate all users
rake users_engine:users:activate_all
```

#### Auth Strategies
```bash
# List auth strategies
rake users_engine:auth_strategies:list

# Create auth strategies from YAML
rake users_engine:auth_strategies:create[yaml_path]
```

### PersonasEngine Tasks

#### Work Positions
```bash
# List all work positions
rake personas_engine:work_positions:list

# Create work positions from YAML
rake personas_engine:work_positions:create[yaml_path]
# Example: rake personas_engine:work_positions:create[data/work_positions.yml]

# Recalculate work positions for all people
rake personas_engine:work_positions:recalculate

# Transfer people from one position to another
rake personas_engine:work_positions:assign_to_user[initial_position_code,target_position_code]
# Example: rake personas_engine:work_positions:assign_to_user[engineer,senior_engineer]
```

#### Setup
```bash
# Setup personas engine (creates default data)
rake personas_engine:setup
```

### Background Jobs (Delayed Job)

```bash
# Start a worker
rake jobs:work

# Work off all jobs and exit
rake jobs:workoff

# Clear the queue
rake jobs:clear

# Check for stuck jobs (older than X seconds)
rake jobs:check[3600]  # Check for jobs older than 1 hour
```

## Deployment

This project includes:
- **Dockerfile**: For containerized deployment
- **Kamal**: For deployment automation (`.kamal/`)

Deployment setup will be configured in later phases.

## Troubleshooting

### Database Connection Failed

```bash
# Check MySQL is running
mysql.server status

# Start MySQL
mysql.server start

# Verify credentials in .env
```

### Port Already in Use

```bash
# Kill existing Rails processes
pkill -f "rails s"
pkill -f puma

# Or use a different port
rails s -p 3002
```

### Engine Not Found

Verify engine paths in `Gemfile` point to your local `bro-garden-on-rails` installation:

```ruby
gem "users_engine", path: "../../nebula-project/bro-garden-on-rails/engines/users"
```

## Documentation

- **CLAUDE.md**: Comprehensive technical documentation
- **data/README.md**: Reference data structure and usage
- **Phase Plans**: See `phase-*.md` files (not in git)

## Project Status

**Current Phase**: Phase 1 Complete ✅

- ✅ Rails application setup
- ✅ Engine integration (users, personas)
- ✅ OAuth2 authentication configured
- ✅ Database schema and seeds
- ✅ CORS enabled for frontend
- ⏳ ChatEngine (Phase 2)
- ⏳ Real-time features (Phase 3)

## Contributing

This is a private project. For questions or issues, contact the development team.

## License

Proprietary - All rights reserved
