.PHONY: up down reset status shell

up:
	docker compose up -d --build

down:
	docker compose down

reset:
	docker compose down
	docker compose up -d --build

status:
	docker compose ps

shell:
	docker compose exec kali /bin/bash