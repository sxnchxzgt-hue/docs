# Bazaar Docs

Centralized documentation for BazaarApp.

This repository is also responsible for tracking story point usage history across repositories and teams.

---

# Bazaar - Repository Structure

## General Architecture

The Bazaar system is organized into four main parts:

- User Backend
- API Gateway
- Frontend App
- Frontend Backoffice

---

## Main Repositories

| Part | Repository | Description | Technology |
|------|------------|-------------|------------|
| Backend Users | `UserService` | User microservice (authentication, profiles, accounts) | Go (Microservice) |
| API Gateway | `ApiGateway` | Entry point to microservices | Go / API Gateway |
| Frontend App | `BazaarApp` | Main user application | Web/Mobile Frontend |
| Frontend Backoffice | `BazaarBackoffice` | Admin panel | Web Frontend |

---

## Support Repositories

| Type | Repository | Description |
|------|------------|-------------|
| Infrastructure | `infra-platform` | AWS infrastructure (VPC, ALB, ECS, RDS) |
| Backend Template | `golang-api-template` | Template for Go microservices |
| Backend Template | `python-template-api` | Template for Python microservices |
| UX | `Uxtemplate` | UI components and design |
| AI / Automation | `Agents-skills` | Skills and automation |

---

# Team Git Workflow 

## Branch Strategy

The project follows a structured branching strategy:

### Main Branches

#### main
- Production-ready
- Deployed
- Verified in production
- Safe for demos

#### dev
- Features that are working but not yet production-ready
- Integrated development branch
- Must pass CI tests before merging

### Feature Branches

- Created from `dev`
- Used for developing new features
- Merged into `dev` via Pull Request

Before merging to `dev`:

- Feature works locally
- Tests pass in GitHub Actions
- Pull request reviewed
- No breaking changes

---
