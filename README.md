# Crypto Exchange

This is a simple app to list the current exchanges.

## Project specifications and tools

- MVVM-C
- Modularized with SPM
- UIKit with ViewCode
- Combine for reactiveness
- Github Actions to build and test the app after each push/PR to develop
- Script to generate `Environment.swift` based on `.env`
- Makefile to generate `Environment` file and run tests

## What is needed to run?

1. Create a `.env` file based on the `.env.template` and put your API Key there
2. Run `make` on the terminal to create the Environment file with the API Key
3. Open Xcode, run the app, should be good!

## Roadmap

- Add exchange logo on the screens (should do)
- Add pull to refresh to improve user experience (should do)
- Add CoreData/SwiftData support for offline mode - see the last feched data (could do)