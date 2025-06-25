version: '3.8'

services:
  # --- PostgreSQL Database Service ---
  postgres:
    image: postgres:15
    container_name: nocodb-postgres-db
    restart: unless-stopped
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
    volumes:
      - data:/var/lib/postgresql/data
    networks:
      - nocodb-net

  # --- NocoDB Service ---
  nocodb:
    image: nocodb/nocodb:latest
    container_name: nocodb-app
    restart: unless-stopped
    ports:
      - "${NOCODB_PORT}:8080"
    environment:
      NC_DB: "pg://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}"
    depends_on:
      - postgres
    networks:
      - nocodb-net

volumes:
  data:

networks:
  nocodb-net: