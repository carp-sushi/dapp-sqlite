.PHONY: all
all: format compile quality

.PHONY: format
format:
	mix format

.PHONY: compile
compile:
	mix compile --warnings-as-errors --all-warnings

.PHONY: test
test:
	mix test --trace

.PHONY: coverage
coverage:
	mix test --cover

.PHONY: quality
quality:
	mix quality

.PHONY: clean
clean:
	mix clean

.PHONY: run
run:
	iex -S mix

.PHONY: release
release:
	MIX_ENV=prod mix release

.PHONY: replicate
replicate:
	@litestream replicate -config litestream.yml

.PHONY: restore
restore:
	@litestream restore -if-db-not-exists -config litestream.yml ${DB_PATH}
