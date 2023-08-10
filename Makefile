.PHONY: all gemini gopher twthash database test help deps

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all               Perform all actions"
	@echo "  gemini            Compile Gemini support"
	@echo "  gopher            Compile Gopher support"
	@echo "  twthash           Compile Twt hash support"
	@echo "  database          Set up DB"
	@echo "  test              Run tests"
	@echo "  deps              Install dependencies for Go builds"
	@echo "  help              Show this help message"

all: deps gemini gopher twthash database test

gemini:
	@if [ -f lib/gemini/gemini.go ]; then \
		echo "Compiling Gemini support..."; \
		cd lib/gemini; \
		go build -o libgemini.so -buildmode=c-shared gemini.go; \
		if [ -f libgemini.so ]; then \
			echo "Gemini support compiled"; \
		else \
			echo "Failed to compile Gemini support"; \
			exit 1; \
		fi; \
		cd ../..; \
	else \
		echo "Error: lib/gemini/gemini.go not found. Make sure you're in the right directory."; \
		exit 1; \
	fi

gopher:
	@echo "Compiling Gopher support..."
	@cd lib/gopher; \
	gcc -shared -o libgopher.so gopher.c; \
	if [ -f libgopher.so ]; then \
		echo "Gopher support compiled"; \
		cd ../..; \
	else \
		echo "Failed to compile Gopher support"; \
		exit 1; \
	fi

twthash:
	@echo "Compiling Twt hash support..."
	@cd lib/twt_hash; \
	go build -o libtwthash.so --buildmode=c-shared twthash.go; \
	if [ -f libtwthash.so ]; then \
		echo "Twt hash support compiled"; \
		cd ../..; \
	else \
		echo "Failed to compile Twt hash support"; \
		exit 1; \
	fi

database:
	@echo "Setting up DB..."
	@cd db; \
	go build setup.go; \
	if [ -f setup ]; then \
		./setup; \
		echo "DB setup complete"; \
		rm setup; \
		cd ..; \
	else \
		echo "Failed to set up DB"; \
		exit 1; \
	fi

test:
	@echo "Running tests..."
	@if bundle exec rspec; then \
		echo "Tests passed! You're good to go! (For more details, run 'rake spec')"; \
	else \
		echo "Tests failed. Something must have gone wrong during setup."; \
		exit 1; \
	fi
deps:
	@echo "Installing dependencies..."
	@cd db; \
	go get -u gorm.io/gorm; \
	go get -u gorm.io/driver/sqlite; \
	go get -u github.com/jinzhu/inflection; \
	go get -u github.com/jinzhu/now; \
	go get -u github.com/mattn/go-sqlite3; \
	cd ../lib/twt_hash; \
	go get -u github.com/dchest/blake2b; \
	cd ../..; \
	bundle > /dev/null; \
