# Contributing to Orbit Smart Contracts

Thank you for your interest in contributing to Orbit smart contracts! This document provides guidelines and information for contributors.

## 🚀 Getting Started

### Prerequisites

- Rust 1.70+ with `rustup`
- Soroban CLI
- Stellar CLI tools
- Git

### Development Setup

1. **Fork and Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/orbit-Contract.git
   cd orbit-Contract
   git remote add upstream https://github.com/IoOrbit/orbit-Contract.git
   ```

2. **Install Soroban CLI**
   ```bash
   cargo install --locked soroban-cli
   ```

3. **Build Contracts**
   ```bash
   make build
   ```

4. **Run Tests**
   ```bash
   make test
   ```

## 🏗 Architecture Overview

The smart contract suite follows a modular architecture:

```
contracts/
├── guild/             # Guild staking and accountability
├── escrow/            # Milestone escrow payments
├── achievement/       # Achievement NFT tokens
├── reward/            # Reward distribution
└── registry/          # Contract registry
```

## 🧪 Testing

### Running Tests

```bash
# Run all contract tests
make test

# Run specific contract tests
make test-guild
make test-escrow
make test-achievement

# Run tests with coverage
make test-coverage
```

### Test Structure

```rust
#[cfg(test)]
mod tests {
    use super::*;
    use soroban_sdk::{Env, Address};

    #[test]
    fn test_contract_function() {
        let env = Env::default();
        let contract_id = env.register_contract(None, YourContract {});
        let client = YourContractClient::new(&env, &contract_id);
        
        // Test implementation
        let result = client.your_function(&test_arg);
        assert_eq!(result, expected_result);
    }
}
```

## 📝 Code Style

We use the following tools for code quality:

- **Formatting**: `cargo fmt`
- **Linting**: `cargo clippy`
- **Security**: `cargo audit`

Run all checks before submitting:

```bash
cargo fmt --check
cargo clippy -- -D warnings
cargo audit
```

## 🔒 Security Guidelines

### Security Checklist

Before submitting, ensure your contract:

- [ ] Validates all external inputs
- [ ] Implements proper access controls
- [ ] Prevents reentrancy attacks
- [ ] Handles integer overflow/underflow
- [ ] Uses secure random number generation
- [ ] Emits events for state changes
- [ ] Has gas optimization

### Security Best Practices

```rust
// Example of secure input validation
pub fn secure_function(env: Env, user: Address, amount: i128) -> bool {
    // Validate input
    if amount <= 0 {
        return false;
    }
    
    // Check authorization
    if env.current_contract_address() != user {
        return false;
    }
    
    // Implement business logic
    // ...
    
    true
}
```

## 🔄 Development Workflow

### 1. Create Branch

```bash
git checkout -b feature/your-contract-name
# or
git checkout -b fix/your-bug-fix
```

### 2. Make Changes

- Follow existing contract patterns
- Add comprehensive tests
- Update documentation
- Consider gas optimization

### 3. Test Your Changes

```bash
make test
cargo fmt
cargo clippy
```

### 4. Commit

```bash
git add .
git commit -m "feat: add your contract description"
```

Follow [Conventional Commits](https://www.conventionalcommits.org/) format:
- `feat:` for new contracts/features
- `fix:` for bug fixes
- `docs:` for documentation
- `refactor:` for refactoring
- `test:` for adding tests

### 5. Push and Create PR

```bash
git push origin feature/your-contract-name
```

Create a Pull Request with:
- Clear title and description
- Link to relevant issues
- Test results
- Gas analysis if applicable

## 🎯 Areas for Contribution

### High Priority

- **Core Contracts**: Guild, escrow, achievement, reward contracts
- **Security**: Security audits and improvements
- **Testing**: Test coverage and test utilities
- **Documentation**: Contract documentation

### Medium Priority

- **Optimization**: Gas and performance improvements
- **Tooling**: Development scripts and utilities
- **Examples**: Usage examples and tutorials
- **Integration**: Cross-contract integration

### Low Priority

- **Upgrades**: Contract upgrade mechanisms
- **Analytics**: Gas usage analysis
- **Monitoring**: Contract monitoring tools
- **Research**: New contract patterns

## 📜 Contract Development Guidelines

### Contract Structure

```rust
use soroban_sdk::{contract, contractimpl, Address, Env, String};

#[contract]
pub struct YourContract {
    // Contract state
}

#[contractimpl]
impl YourContract {
    // Constructor
    pub fn __constructor(env: Env, admin: Address) {
        // Initialize contract
    }
    
    // Public functions
    pub fn your_function(env: Env, user: Address) -> bool {
        // Function implementation
    }
    
    // Private functions (internal)
    fn internal_function(env: Env, data: &str) -> i128 {
        // Internal logic
    }
}
```

### Error Handling

```rust
use soroban_sdk::{contracterror, contractimpl};

#[contracterror]
#[derive(Clone, Debug, Eq, PartialEq)]
pub enum Error {
    Unauthorized = 1,
    InvalidAmount = 2,
    InsufficientBalance = 3,
}

#[contractimpl]
impl YourContract {
    pub fn transfer(env: Env, from: Address, to: Address, amount: i128) -> Result<(), Error> {
        if amount <= 0 {
            return Err(Error::InvalidAmount);
        }
        
        // Transfer logic
        
        Ok(())
    }
}
```

### Events

```rust
use soroban_sdk::{contractevent, symbol_short};

#[contractevent]
pub struct TransferEvent {
    pub from: Address,
    pub to: Address,
    pub amount: i128,
}

#[contractimpl]
impl YourContract {
    pub fn transfer(env: Env, from: Address, to: Address, amount: i128) -> Result<(), Error> {
        // Transfer logic
        
        env.events().publish(
            symbol_short!("TRANSFER"),
            TransferEvent { from, to, amount },
        );
        
        Ok(())
    }
}
```

## 🚀 Deployment

### Testnet Deployment

```bash
# Deploy all contracts
make deploy-testnet

# Deploy specific contract
make deploy-guild-testnet

# Initialize contracts
make init-testnet
```

### Mainnet Deployment

Mainnet deployment requires additional security checks:

1. **Security Audit**: Contract must be audited
2. **Gas Analysis**: Provide gas usage analysis
3. **Testing**: Comprehensive test coverage
4. **Documentation**: Complete documentation

## 📊 Gas Optimization

### Optimization Techniques

- Use efficient data structures
- Minimize storage operations
- Batch operations when possible
- Use events for off-chain data

### Gas Analysis

```bash
# Analyze gas usage
make analyze-gas

# Benchmark implementations
make benchmark
```

## 🐛 Bug Reports

When reporting bugs, please include:

- **Contract**: Which contract is affected
- **Function**: Which function has the issue
- **Environment**: Testnet/mainnet, Soroban version
- **Steps to Reproduce**: Detailed reproduction steps
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happens
- **Error Messages**: Full error logs
- **Transaction Hash**: If applicable

## 💡 Feature Requests

For feature requests:

- **Problem**: What problem does this solve?
- **Solution**: How should the contract work?
- **Use Case**: Who benefits and how?
- **Alternatives**: What alternatives did you consider?
- **Additional Context**: Background information

## 🔒 Security

If you find a security vulnerability:

1. **DO NOT** open a public issue
2. Email us at security@orbit-app.io
3. Include details about the vulnerability
4. We'll respond within 48 hours

## 📚 Resources

- [Soroban Documentation](https://soroban.stellar.org/)
- [Rust Book](https://doc.rust-lang.org/book/)
- [Smart Contract Security](https://consensys.github.io/smart-contract-best-practices/)
- [Stellar SDK](https://github.com/stellar/js-stellar-sdk)

## 🤝 Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## 📄 License

By contributing, you agree that your contributions will be licensed under MIT License.

## 🆘 Getting Help

- **Discord**: [Join our community](https://discord.gg/orbit)
- **GitHub Issues**: [Open an issue](https://github.com/IoOrbit/orbit-Contract/issues)
- **Documentation**: [Contract Docs](https://docs.orbit-app.io/contracts)

---

Happy coding! 🚀
