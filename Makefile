# Levantar la Infraestructura de la Arquitectura

.DEFAULT_GOAL := help
logo:
	clear
	@echo "┌──────────────────────────────────────────────┐"
	@echo "│ ███████╗███████╗███╗   ██╗████████╗██╗   ██╗ │"
	@echo "│ ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║   ██║ │"
	@echo "│ ███████╗█████╗  ██╔██╗ ██║   ██║   ██║   ██║ │"
	@echo "│ ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║   ██║ │"
	@echo "│ ███████║███████╗██║ ╚████║   ██║   ╚██████╔╝ │"
	@echo "│ ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝  │"
	@echo "└─────────────────────────────────────┤studio├─┘"
	@echo " SISPROT GLOBAL FIBER                           "
	@echo ""

## Muestra la ayuda en pantalla
help: logo
	@awk '/^##.*$$/,/^[~\/\.0-9a-zA-Z_-]+:/' $(MAKEFILE_LIST) | awk '!(NR%2){print $$0p}{p=$$0}' | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' | sort

## Construye el proyecto local.yml en docker compose
build: logo
	docker compose -f local.yml up --build -d --remove-orphans

## Levanta la orquestación de contenedores en local.yml
up: logo
	docker compose -f local.yml up -d

## Detiene la orquestación de contenedores en local.yml
down: logo
	docker compose -f local.yml down

## Muestra los logs de la orquestación de contenedores en local.yml
show_logs: logo
	docker compose -f local.yml logs

## Migra la base de datos del proyecto en el contenedor api de docker
migrate: logo
	docker compose -f local.yml run --rm api python3 manage.py migrate

## Ejecuta la migración de la base de datos
makemigrations: logo
	docker compose -f local.yml run --rm api python3 manage.py makemigrations

## Recolecta la colección de archivos estáticos del proyecto
collectstatic: logo
	docker compose -f local.yml run --rm api python3 manage.py collectstatic --no-input --clear

## Crea el superusuario del proyecto en django
superuser: logo
	docker compose -f local.yml run --rm api python3 manage.py createsuperuser

## Detiene los contenedores del proyecto y elimina los volúmenes
down-v: logo
	docker compose -f local.yml down -v

## Muestra el contenido del volumen de la base de datos
volume: logo
	docker volume inspect src_local_postgres_data

## Entra directamente al promp de la base de datos
sisprot-db: logo
	docker compose -f local.yml exec postgres psql --username=sisprot --dbname=sisprot-online

## Comprueba que flake8 se cumpla
flake8: logo
	docker compose -f local.yml exec api flake8 .

## Chequea la estructura python con black
black-check: logo
	docker compose -f local.yml exec api black --check --exclude=migrations .

## Muestra la diferencia del chequeo de black
black-diff: logo
	docker compose -f local.yml exec api black --diff --exclude=migrations .

## Ejecuta el comando black para python 
black: logo
	docker compose -f local.yml exec api black --exclude=migrations .

## Chequea el orden de las librerias importadas en el proyecto django
isort-check: logo
	docker compose -f local.yml exec api isort . --check-only --skip env --skip migrations

## Muestra la diferencia antes de aplicar el comando isort en django
isort-diff: logo
	docker compose -f local.yml exec api isort . --diff --skip env --skip migrations

## Aplica el comando isort
isort: logo
	docker compose -f local.yml exec api isort . --skip env --skip migrations

