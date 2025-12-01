# Paths to compose files
DEV_COMPOSE = docker/compose.development.yaml
PROD_COMPOSE = docker/compose.production.yaml

# ---------- DEVELOPMENT ----------

## Build and run the full dev stack (gateway + backend + mongo)
dev-up:
	docker compose -f $(DEV_COMPOSE) up --build

## Stop dev stack (containers only, keep volumes)
dev-down:
	docker compose -f $(DEV_COMPOSE) down

## Follow dev logs
dev-logs:
	docker compose -f $(DEV_COMPOSE) logs -f

## Rebuild dev images from scratch (use if deps/Dockerfile changed)
dev-rebuild:
	docker compose -f $(DEV_COMPOSE) down
	docker compose -f $(DEV_COMPOSE) up --build

# ---------- PRODUCTION ----------

## Run prod stack using existing images (NO rebuild)
prod-up:
	docker compose -f $(PROD_COMPOSE) up -d

## Stop prod stack
prod-down:
	docker compose -f $(PROD_COMPOSE) down

## Follow prod logs
prod-logs:
	docker compose -f $(PROD_COMPOSE) logs -f

## Rebuild prod images explicitly (only if really needed)
prod-rebuild:
	docker compose -f $(PROD_COMPOSE) down
	docker compose -f $(PROD_COMPOSE) up --build

# ---------- UTILITIES ----------

## Show running containers for this project
ps:
	docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

## Stop everything and prune unused Docker objects (careful)
clean:
	docker compose -f $(DEV_COMPOSE) down -v || true
	docker compose -f $(PROD_COMPOSE) down -v || true
	docker system prune -f

.PHONY: dev-up dev-down dev-logs dev-rebuild \
        prod-up prod-down prod-logs prod-rebuild \
        ps clean
