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

# Deployment & Infrastructure Strategy

## Infrastructure Availability

There are two possible approaches for deployment infrastructure:

### Option 1 — Always-On Infrastructure
- Infrastructure remains active
- Easier testing and faster iteration
- Higher cost

### Option 2 — On-Demand Infrastructure
- Infrastructure is deployed only when needed
- Used for testing new features in production-like environments
- Resources are destroyed after testing
- Lower cost but slower iteration

The chosen approach will depend on budget constraints.

For now, the team will evaluate:

- Cost of keeping infrastructure alive for short periods (3–4 hours)
- Development workflow impact
- Testing needs

This decision will be finalized after cost analysis.

---

# QA Strategy (Temporary)

Until proper deployment environments are available:

- Frontend and Backend integration will be tested locally
- Developers must coordinate testing
- API contracts must be respected
- This applies especially to mobile testing limitations

This temporary workflow will remain in place **until Issue #48 is closed**.

---

# Security Strategy

## Checkpoint 2 - Initial Security Approach

A dedicated card will be created for **Checkpoint 3** to address security concerns.

### Initial Approach

- Allow functionality first
- Avoid blocking development
- Implement basic security where necessary
- Refine security progressively

### Later Improvements

Security will be refined iteratively:

- Authentication hardening
- Authorization rules
- API protection
- Infrastructure security

This allows faster development while ensuring security is introduced early and improved over time.
