#!/bin/bash
# ============================================================
# seed-all.sh — Seed completo de GranBazaar
# Aplica los 4 seeds en orden de dependencia.
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SQL_DIR="$SCRIPT_DIR/sql"

# ─── Configuración por servicio ──────────────────────────────────────────────
# Sobreescribibles via variables de entorno o archivo .env en la raíz del repo

if [ -f "$SCRIPT_DIR/.env" ]; then
    export $(cat "$SCRIPT_DIR/.env" | grep -v '^#' | xargs)
fi

# UserService
US_HOST=${US_HOST:-localhost}
US_PORT=${US_PORT:-5432}
US_USER=${US_USER:-granbazaar}
US_PASS=${US_PASS:-granbazaar}
US_DB=${US_DB:-granbazaar}

# CatalogService (CartService)
CS_HOST=${CS_HOST:-localhost}
CS_PORT=${CS_PORT:-5433}
CS_USER=${CS_USER:-postgres}
CS_PASS=${CS_PASS:-postgres}
CS_DB=${CS_DB:-granbazaar_catalog}

# CheckoutOrdersService
CO_HOST=${CO_HOST:-localhost}
CO_PORT=${CO_PORT:-5434}
CO_USER=${CO_USER:-postgres}
CO_PASS=${CO_PASS:-postgres}
CO_DB=${CO_DB:-granbazaar_checkout_order}

# WishListService
WL_HOST=${WL_HOST:-localhost}
WL_PORT=${WL_PORT:-5435}
WL_USER=${WL_USER:-postgres}
WL_PASS=${WL_PASS:-postgres}
WL_DB=${WL_DB:-granbazaar_wishlist}

# MetricsService (MongoDB)
export MONGO_URI=${MONGO_URI:-mongodb://admin:secretpassword@localhost:27017}
export MONGO_DB_NAME=${MONGO_DB_NAME:-metrics_db}

# ─── Colores ──────────────────────────────────────────────────────────────────

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

run_sql() {
    local label="$1" host="$2" port="$3" user="$4" pass="$5" db="$6" file="$7"
    echo -e "${BLUE}▶ Seeding $label ($db @ $host:$port)...${NC}"
    PGPASSWORD="$pass" psql -h "$host" -p "$port" -U "$user" -d "$db" -f "$file" -v ON_ERROR_STOP=1
    echo -e "${GREEN}  ✓ $label seeded${NC}"
}

# ─── Validaciones previas ─────────────────────────────────────────────────────

if ! command -v psql &> /dev/null; then
    echo "Error: psql no encontrado en PATH. Instalar postgresql-client."
    exit 1
fi

echo -e "${YELLOW}GranBazaar — Seed completo${NC}"
echo "SQL dir: $SQL_DIR"
echo ""

# ─── Ejecución en orden de dependencia ───────────────────────────────────────

run_sql "UserService"           "$US_HOST" "$US_PORT" "$US_USER" "$US_PASS" "$US_DB" "$SQL_DIR/01_users.sql"
run_sql "CatalogService"        "$CS_HOST" "$CS_PORT" "$CS_USER" "$CS_PASS" "$CS_DB" "$SQL_DIR/02_catalog.sql"
run_sql "CheckoutOrdersService" "$CO_HOST" "$CO_PORT" "$CO_USER" "$CO_PASS" "$CO_DB" "$SQL_DIR/03_checkout.sql"
run_sql "WishListService"       "$WL_HOST" "$WL_PORT" "$WL_USER" "$WL_PASS" "$WL_DB" "$SQL_DIR/04_wishlist.sql"

# ─── Ejecución del Seed de MongoDB (Entorno Aislado) ─────────────────────────

MONGO_DIR="$SCRIPT_DIR/mongo"
VENV_DIR="$MONGO_DIR/.venv"

echo -e "${BLUE}▶ Preparando entorno de Python para MetricsService...${NC}"

# Crear el entorno virtual e instalar dependencias si no existe
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${YELLOW}  Creando entorno virtual en $VENV_DIR...${NC}"
    python3 -m venv "$VENV_DIR"
    
    echo -e "${YELLOW}  Instalando dependencias (beanie, motor)...${NC}"
    "$VENV_DIR/bin/pip" install --quiet -r "$MONGO_DIR/requirements.txt"
fi

echo -e "${BLUE}▶ Seeding MetricsService (MongoDB / Beanie)...${NC}"
# Ejecutamos el script usando el python del entorno virtual aislado
PYTHONPATH="$SCRIPT_DIR/.." "$VENV_DIR/bin/python3" "$MONGO_DIR/05_metrics_seed.py"
echo -e "${GREEN}  ✓ MetricsService seeded${NC}"

echo ""
echo -e "${GREEN}✓ Todos los servicios seeded correctamente.${NC}"
