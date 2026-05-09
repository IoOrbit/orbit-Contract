.PHONY: help build test clean deploy-testnet deploy-mainnet analyze-gas

# Default target
help:
	@echo "Available commands:"
	@echo "  build          - Build all contracts"
	@echo "  test           - Run all contract tests"
	@echo "  test-guild     - Run guild contract tests"
	@echo "  test-escrow    - Run escrow contract tests"
	@echo "  test-achievement - Run achievement contract tests"
	@echo "  test-reward    - Run reward contract tests"
	@echo "  deploy-testnet - Deploy contracts to testnet"
	@echo "  deploy-mainnet - Deploy contracts to mainnet"
	@echo "  analyze-gas    - Analyze gas usage"
	@echo "  clean          - Clean build artifacts"
	@echo "  setup          - Setup development environment"

# Build all contracts
build:
	cargo build --release --target wasm32-unknown-unknown

# Build specific contract
build-guild:
	cd contracts/guild && cargo build --release --target wasm32-unknown-unknown

build-escrow:
	cd contracts/escrow && cargo build --release --target wasm32-unknown-unknown

build-achievement:
	cd contracts/achievement && cargo build --release --target wasm32-unknown-unknown

build-reward:
	cd contracts/reward && cargo build --release --target wasm32-unknown-unknown

build-registry:
	cd contracts/registry && cargo build --release --target wasm32-unknown-unknown

# Run all tests
test:
	cargo test

# Run specific contract tests
test-guild:
	cd contracts/guild && cargo test

test-escrow:
	cd contracts/escrow && cargo test

test-achievement:
	cd contracts/achievement && cargo test

test-reward:
	cd contracts/reward && cargo test

test-registry:
	cd contracts/registry && cargo test

# Run tests with coverage
test-coverage:
	cargo tarpaulin --out Html --workspace

# Deploy to testnet
deploy-testnet: build
	./scripts/deploy.sh testnet

# Deploy specific contract to testnet
deploy-guild-testnet: build-guild
	./scripts/deploy-contract.sh guild testnet

deploy-escrow-testnet: build-escrow
	./scripts/deploy-contract.sh escrow testnet

deploy-achievement-testnet: build-achievement
	./scripts/deploy-contract.sh achievement testnet

deploy-reward-testnet: build-reward
	./scripts/deploy-contract.sh reward testnet

# Deploy to mainnet
deploy-mainnet: build
	./scripts/deploy.sh mainnet

# Initialize contracts on network
init-testnet:
	./scripts/init.sh testnet

init-mainnet:
	./scripts/init.sh mainnet

# Update contract registry
update-registry-testnet:
	./scripts/update-registry.sh testnet

# Analyze gas usage
analyze-gas:
	./scripts/analyze-gas.sh

# Benchmark contracts
benchmark:
	./scripts/benchmark.sh

# Verify contracts
verify:
	./scripts/verify.sh

# Clean build artifacts
clean:
	cargo clean
	rm -rf target/

# Setup development environment
setup:
	@echo "Setting up development environment..."
	cargo install --locked soroban-cli
	cargo install cargo-tarpaulin
	@echo "Development environment setup complete!"

# Generate contract bindings
bindings:
	./scripts/generate-bindings.sh

# Run contract examples
examples:
	./scripts/run-examples.sh

# Lint contracts
lint:
	cargo clippy -- -D warnings

# Format code
format:
	cargo fmt

# Security audit
audit:
	cargo audit

# Run all checks
check: format lint test
	@echo "All checks passed!"

# Documentation
docs:
	cargo doc --open
