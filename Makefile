.PHONY: start
start:
	docker compose up --detach

.PHONY: restart
restart:
	docker compose restart

.PHONY: stop
stop:
	docker compose stop

.PHONY: clean
clean:
	docker compose down --volumes

.PHONY: run
run:
	docker compose exec -it main /bin/bash
