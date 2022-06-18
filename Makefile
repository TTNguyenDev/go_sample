postgres:
	docker run --name postgres_14 -d -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret postgres:14.3-alpine

createdb:
	docker exec -it postgres_14 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres_14 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 

sqlc: 
	sqlc generate

.PHONY: prostgres createdb dropdb migrateup migratedown sqlc
