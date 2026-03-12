all: test

clean:
		rm -rf build dist
		find . -name '*.pyc' -exec rm \{\} \;
		py3clean .

install:
		@# Install OpenFisca-France-Indirect-Taxation-Data for development (without optional model).
		uv sync

build: clean install
		@# Build the distribution artifacts for the data package.
		uv build

check-syntax-errors:
		uv run python -m compileall -q .

format-style:
		@# Do not analyse .gitignored files.
		@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
		uv run ruff format `git ls-files | grep "\.py$$"`

check-style:
		@# Do not analyse .gitignored files.
		@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
		uv run ruff check `git ls-files | grep "\.py$$"`

test: clean check-syntax-errors check-style
		@# For now, run a basic pytest suite on the data package (no OpenFisca tests here).
		uv run pytest

