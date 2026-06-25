import os
import asyncio
import random
import uuid
from datetime import datetime, timedelta, UTC
from typing import Any, Literal
from beanie import Document, init_beanie
from pydantic import Field
from motor.motor_asyncio import AsyncIOMotorClient

# ─── Modelos Beanie (Event Sourcing) ──────────────────────────────────────────

OrderEventType = Literal["ORDER_CREATED", "ORDER_CONFIRMED", "ORDER_CANCELLED"]
ProductEventType = Literal["PRODUCT_CREATED", "PRODUCT_UPDATED", "PRODUCT_SOLD", "PRODUCT_DELETED"]
UserEventType = Literal["USER_REGISTERED"]


class OrderMetricEvent(Document):
    event_type: OrderEventType = Field(..., description="Type of order metric event")
    order_id: str = Field(..., description="ID of the order associated with this event")
    timestamp: datetime = Field(
        default_factory=lambda: datetime.now(UTC), description="Timestamp of the event in UTC"
    )
    actor: str = Field(..., description="Who performed the action")
    payload: dict[str, Any] = Field(
        default_factory=dict, description="Details of the order event"
    )

    class Settings:
        name = "order_metric_events"
        indexes = ["order_id", "timestamp"]


class ProductMetricEvent(Document):
    event_type: ProductEventType = Field(..., description="Type of product metric event")
    product_id: str = Field(..., description="ID of the product associated with this event")
    timestamp: datetime = Field(
        default_factory=lambda: datetime.now(UTC), description="Timestamp of the event in UTC"
    )
    actor: str = Field(..., description="Who performed the action")
    payload: dict[str, Any] = Field(
        default_factory=dict, description="Details of the product event"
    )

    class Settings:
        name = "product_metric_events"
        indexes = ["product_id", "timestamp"]


class UserMetricEvent(Document):
    event_type: UserEventType = Field(..., description="Type of user metric event")
    user_id: str = Field(..., description="ID of the user associated with this event")
    timestamp: datetime = Field(
        default_factory=lambda: datetime.now(UTC), description="Timestamp of the event in UTC"
    )
    actor: str = Field(..., description="Who performed the action")
    payload: dict[str, Any] = Field(
        default_factory=dict, description="Details of the user event"
    )

    class Settings:
        name = "user_metric_events"
        indexes = ["user_id", "timestamp"]


# ─── Datos Ficticios para Usuarios ──────────────────────────────────────────

FIRST_NAMES = [
    "Juan", "Ana", "Luis", "Sofia", "Carlos", "Maria", "Pedro", "Lucia",
    "Diego", "Elena", "Javier", "Laura", "Miguel", "Isabel", "Andres", "Clara"
]
LAST_NAMES = [
    "Gomez", "Rodriguez", "Fernandez", "Lopez", "Diaz", "Martinez", "Perez",
    "Garcia", "Sanchez", "Romero", "Alvarez", "Torres", "Ruiz", "Ramirez"
]


def generate_fake_user(index: int) -> tuple[str, str]:
    first_name = random.choice(FIRST_NAMES)
    last_name = random.choice(LAST_NAMES)
    full_name = f"{first_name} {last_name}"
    email = f"{first_name.lower()}.{last_name.lower()}.{index}@example.com"
    return full_name, email


# ─── Proceso de Seeding ───────────────────────────────────────────────────────

async def seed_data() -> None:
    print("Iniciando seeding de métricas...")

    # 1. Limpiar colecciones
    print("Limpiando datos existentes...")
    await UserMetricEvent.find_all().delete()
    await ProductMetricEvent.find_all().delete()
    await OrderMetricEvent.find_all().delete()

    now = datetime.now(UTC)
    day_90_ago = now - timedelta(days=90)

    # 2. Generar Compradores y Vendedores reales
    real_buyers = [
        ("cccccccc-cccc-cccc-cccc-cccccccccc01", "Laura Méndez", "laura.mendez@example.com"),
        ("cccccccc-cccc-cccc-cccc-cccccccccc02", "Carlos Herrera", "carlos.herrera@example.com"),
        ("cccccccc-cccc-cccc-cccc-cccccccccc03", "María García", "maria.garcia@example.com")
    ]

    real_sellers = [
        f"550e8400-e29b-41d4-a716-44665544000{i}" for i in range(1, 8)
    ]

    real_seller_names = {
        "550e8400-e29b-41d4-a716-446655440001": "TecnoShop BA",
        "550e8400-e29b-41d4-a716-446655440002": "Moda Porteña",
        "550e8400-e29b-41d4-a716-446655440003": "Casa & Deco",
        "550e8400-e29b-41d4-a716-446655440004": "Bella Natura",
        "550e8400-e29b-41d4-a716-446655440005": "El Mundo del Niño",
        "550e8400-e29b-41d4-a716-446655440006": "SportZone Pro",
        "550e8400-e29b-41d4-a716-446655440007": "Bazar del Centro",
    }

    # Insertar USER_REGISTERED para compradores y vendedores reales en day_90_ago
    user_events: list[UserMetricEvent] = []

    for user_id, name, email in real_buyers:
        event = UserMetricEvent(
            event_type="USER_REGISTERED",
            user_id=user_id,
            timestamp=day_90_ago,
            actor=user_id,
            payload={"full_name": name, "email": email, "role": "buyer"}
        )
        user_events.append(event)

    for seller_id in real_sellers:
        name = real_seller_names[seller_id]
        event = UserMetricEvent(
            event_type="USER_REGISTERED",
            user_id=seller_id,
            timestamp=day_90_ago,
            actor=seller_id,
            payload={
                "full_name": name,
                "email": f"{name.lower().replace(' ', '.').replace('&', 'and')}@example.com",
                "role": "seller"
            }
        )
        user_events.append(event)

    # 3. Generar ~50 usuarios falsos distribuidos en los últimos 3 meses
    fake_buyers: list[tuple[str, datetime]] = []
    for i in range(1, 51):
        full_name, email = generate_fake_user(i)
        user_id = str(uuid.uuid4())
        role = "buyer" if random.random() < 0.8 else "seller"

        reg_days_ago = random.uniform(0, 90)
        reg_timestamp = now - timedelta(days=reg_days_ago)

        event = UserMetricEvent(
            event_type="USER_REGISTERED",
            user_id=user_id,
            timestamp=reg_timestamp,
            actor=user_id,
            payload={"full_name": full_name, "email": email, "role": role}
        )
        user_events.append(event)
        if role == "buyer":
            fake_buyers.append((user_id, reg_timestamp))

    for event in user_events:
        await event.insert()
    print(f"Insertados {len(user_events)} eventos USER_REGISTERED.")

    # 4. Generar Eventos de Producto: PRODUCT_CREATED para los 50 IDs en day_90_ago
    product_events: list[ProductMetricEvent] = []
    product_prices: dict[int, float] = {}
    product_categories: dict[int, str] = {}

    for pid in range(1, 51):
        if pid == 1:
            price, name, cat = 299.99, "Samsung Galaxy A54", "Electrónica"
        elif pid == 2:
            price, name, cat = 79.99, "Auriculares Sony WH-CH720", "Electrónica"
        elif pid == 3:
            price, name, cat = 24.99, "Camiseta Básica Premium", "Ropa"
        elif pid == 4:
            price, name, cat = 89.99, "Zapatillas Running Pro", "Ropa"
        elif pid == 5:
            price, name, cat = 45.99, "Lámpara LED de Piso", "Hogar"
        else:
            price = round(random.uniform(15.0, 450.0), 2)
            name = f"Producto Fake {pid}"
            cat = random.choice(["Electrónica", "Ropa", "Hogar", "Belleza", "Juguetes", "Deportes", "Computación"])

        product_prices[pid] = price
        product_categories[pid] = cat
        seller_id = real_sellers[(pid - 1) % len(real_sellers)]

        event = ProductMetricEvent(
            event_type="PRODUCT_CREATED",
            product_id=str(pid),
            timestamp=day_90_ago,
            actor=seller_id,
            payload={
                "name": name,
                "price": price,
                "category": cat,
                "seller_id": seller_id,
                "stock": random.randint(10, 100)
            }
        )
        product_events.append(event)

    for event in product_events:
        await event.insert()
    print(f"Insertados {len(product_events)} eventos PRODUCT_CREATED.")

    # 5. Generar Eventos de Orden (entre 200 y 300 órdenes)
    num_orders = random.randint(200, 300)
    print(f"Simulando {num_orders} órdenes...")

    product_pool = list(range(1, 51))
    weights = [10 if 1 <= pid <= 5 else 1 for pid in product_pool]

    order_events_to_insert: list[OrderMetricEvent] = []
    product_sold_events_to_insert: list[ProductMetricEvent] = []

    for _ in range(num_orders):
        order_id = str(uuid.uuid4())

        order_days_ago = random.uniform(0, 89)
        order_timestamp = now - timedelta(days=order_days_ago)

        available_buyers = [b[0] for b in real_buyers]
        for fb_id, reg_t in fake_buyers:
            if reg_t < order_timestamp:
                available_buyers.append(fb_id)

        buyer_id = random.choice(available_buyers)

        num_products = random.randint(1, 3)
        chosen_pids: list[int] = []
        temp_pool = list(product_pool)
        temp_weights = list(weights)
        for _ in range(num_products):
            pid = random.choices(temp_pool, weights=temp_weights, k=1)[0]
            idx = temp_pool.index(pid)
            temp_pool.pop(idx)
            temp_weights.pop(idx)
            chosen_pids.append(pid)

        items: list[dict[str, Any]] = []
        total_paid = 0.0
        for pid in chosen_pids:
            price = product_prices[pid]
            quantity = random.randint(1, 2)
            items.append({
                "product_id": str(pid),
                "category_id": product_categories[pid],
                "price": price,
                "quantity": quantity
            })
            total_paid += price * quantity

        total_paid = round(total_paid, 2)

        created_event = OrderMetricEvent(
            event_type="ORDER_CREATED",
            order_id=order_id,
            timestamp=order_timestamp,
            actor=buyer_id,
            payload={
                "buyer_id": buyer_id,
                "items": items,
                "total_paid": total_paid
            }
        )
        order_events_to_insert.append(created_event)

        rand_val = random.random()

        if rand_val < 0.75:
            # ORDER_CONFIRMED + PRODUCT_SOLD
            delay_hours = random.uniform(1, 24)
            confirm_timestamp = order_timestamp + timedelta(hours=delay_hours)

            if confirm_timestamp > now:
                confirm_timestamp = now

            confirmed_event = OrderMetricEvent(
                event_type="ORDER_CONFIRMED",
                order_id=order_id,
                timestamp=confirm_timestamp,
                actor="system",
                payload={
                    "buyer_id": buyer_id,
                    "items": items,
                    "total_paid": total_paid
                }
            )
            order_events_to_insert.append(confirmed_event)

            for item in items:
                sold_event = ProductMetricEvent(
                    event_type="PRODUCT_SOLD",
                    product_id=item["product_id"],
                    timestamp=confirm_timestamp,
                    actor=buyer_id,
                    payload={
                        "quantity": item["quantity"],
                        "price": item["price"],
                        "category": product_categories[int(item["product_id"])],
                        "order_id": order_id
                    }
                )
                product_sold_events_to_insert.append(sold_event)

        elif rand_val < 0.90:
            # ORDER_CANCELLED
            delay_hours = random.uniform(1, 48)
            cancel_timestamp = order_timestamp + timedelta(hours=delay_hours)

            if cancel_timestamp > now:
                cancel_timestamp = now

            cancelled_event = OrderMetricEvent(
                event_type="ORDER_CANCELLED",
                order_id=order_id,
                timestamp=cancel_timestamp,
                actor="system",
                payload={
                    "reason": random.choice(["buyer_cancelled", "payment_failed", "out_of_stock"]),
                    "buyer_id": buyer_id,
                    "total_paid": total_paid
                }
            )
            order_events_to_insert.append(cancelled_event)

    for event in order_events_to_insert:
        await event.insert()
    for event in product_sold_events_to_insert:
        await event.insert()

    print(f"Insertados {len(order_events_to_insert)} eventos de orden (CREATED/CONFIRMED/CANCELLED).")
    print(f"Insertados {len(product_sold_events_to_insert)} eventos PRODUCT_SOLD.")
    print("✓ Seeding de métricas completado exitosamente.")


# ─── Punto de Entrada ─────────────────────────────────────────────────────────

async def main() -> None:
    mongo_uri = os.getenv("MONGO_URI", "mongodb://admin:secretpassword@localhost:27017")
    mongo_db_name = os.getenv("MONGO_DB_NAME", "metrics_db")

    print(f"Conectando a MongoDB en {mongo_uri} (DB: {mongo_db_name})...")
    client = AsyncIOMotorClient(mongo_uri)
    db = client[mongo_db_name]

    await init_beanie(
        database=db,
        document_models=[
            ProductMetricEvent,
            UserMetricEvent,
            OrderMetricEvent,
        ],
    )

    try:
        await seed_data()
    finally:
        client.close()


if __name__ == "__main__":
    asyncio.run(main())