SCRIPT_PATH=generate-env.swift.sh
LINT_CONFIG=.swiftlint.yml

all: env

env:
	@chmod +x $(SCRIPT_PATH)
	@chmod 644 $(LINT_CONFIG)
	@./$(SCRIPT_PATH)

test:
	rm -rf TestResults.xcresult
	xcodebuild clean build test \
		-project CryptoExchange.xcodeproj \
		-scheme CryptoExchange \
		-destination 'platform=iOS Simulator,name=iPhone 16,OS=18.4,arch=arm64' \
		-testPlan CryptoExchangeTestPlan \
		-enableCodeCoverage YES \
		-resultBundlePath TestResults.xcresult \
		| xcpretty --simple --color

clean:
	@rm -f ./Modules/Sources/Networking/Generated/Environment.swift

.PHONY: all env clean