SCRIPT_PATH=generate-env.swift.sh
LINT_CONFIG=.swiftlint.yml

all: env

env:
	@chmod +x $(SCRIPT_PATH)
	@chmod 644 $(LINT_CONFIG)
	@./$(SCRIPT_PATH)

clean:
	@rm -f ./Modules/Sources/Networking/Generated/Environment.swift

.PHONY: all env clean