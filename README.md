# Orbit Smart Contracts

[![Soroban](https://img.shields.io/badge/Soroban-Rust-blue.svg)](https://soroban.stellar.org)
[![Stellar](https://img.shields.io/badge/Stellar-XLM-blue.svg)](https://stellar.org)
[![Rust](https://img.shields.io/badge/Rust-000000?logo=rust)](https://www.rust-lang.org)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Stellar Soroban smart contracts for the Orbit productivity platform, enabling guild staking, milestone escrow, and achievement tokens.

## 🚀 Smart Contract Suite

### Core Contracts

- **Guild Contract** - Multi-signature guild staking and accountability
- **Escrow Contract** - Freelance milestone payments with dispute resolution
- **Achievement Contract** - Non-fungible achievement tokens and credentials
- **Reward Contract** - Automated XLM reward distribution
- **Registry Contract** - Central contract registry and metadata

## 📁 Project Structure

```
orbit-Contract/
├── contracts/              # Smart contract implementations
│   ├── guild/             # Guild staking contract
│   ├── escrow/            # Milestone escrow contract
│   ├── achievement/       # Achievement NFT contract
│   ├── reward/            # Reward distribution contract
│   └── registry/          # Contract registry
├── tests/                 # Contract tests
├── scripts/               # Deployment and utility scripts
├── examples/              # Usage examples
└── docs/                  # Contract documentation
```

## 🛠 Technology Stack

- **Language**: Rust
- **Platform**: Soroban (Stellar Smart Contracts)
- **Framework**: Soroban SDK
- **Testing**: Soroban Test Framework
- **Deployment**: Soroban CLI

## 🚀 Quick Start

### Prerequisites

- Rust 1.70+
- Soroban CLI
- Stellar CLI tools

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/IoOrbit/orbit-Contract.git
   cd orbit-Contract
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

5. **Deploy to Testnet**
   ```bash
   make deploy-testnet
   ```

## 📜 Contract Details

### Guild Contract

Manages creative guilds with multi-signature staking and accountability mechanisms.

**Features:**
- Multi-signature guild creation (3-20 members)
- XLM staking pool management
- Weekly goal tracking and rewards
- Guild leaderboards
- Member voting and governance

**Key Functions:**
```rust
// Create new guild
fn create_guild(
    env: Env,
    name: String,
    members: Vec<Address>,
    stake_amount: i128,
    weekly_goals: Vec<String>,
) -> Address;

// Submit weekly progress
fn submit_progress(
    env: Env,
    guild_id: Address,
    member: Address,
    progress_data: Vec<u32>,
) -> bool;

// Distribute rewards
fn distribute_rewards(
    env: Env,
    guild_id: Address,
    successful_members: Vec<Address>,
) -> bool;
```

### Escrow Contract

Trust-minimized milestone payments for freelance creative work.

**Features:**
- Multi-signature milestone creation
- Client and creator approval workflow
- Automated dispute resolution
- Time-based release mechanisms
- Oracle integration for verification

**Key Functions:**
```rust
// Create milestone escrow
fn create_escrow(
    env: Env,
    client: Address,
    creator: Address,
    milestones: Vec<Milestone>,
    total_amount: i128,
) -> Address;

// Approve milestone
fn approve_milestone(
    env: Env,
    escrow_id: Address,
    milestone_index: u32,
    approver: Address,
) -> bool;

// Release payment
fn release_payment(
    env: Env,
    escrow_id: Address,
    milestone_index: u32,
) -> bool;
```

### Achievement Contract

Non-fungible tokens representing creative accomplishments and credentials.

**Features:**
- Achievement token minting
- Metadata and proof storage
- Portfolio integration
- Verification and validation
- Transfer restrictions (soulbound option)

**Key Functions:**
```rust
// Mint achievement token
fn mint_achievement(
    env: Env,
    recipient: Address,
    achievement_id: String,
    metadata: String,
    proof_data: Bytes,
) -> u32;

// Verify achievement
fn verify_achievement(
    env: Env,
    token_id: u32,
    verifier: Address,
) -> bool;

// Update metadata
fn update_metadata(
    env: Env,
    token_id: u32,
    new_metadata: String,
    owner: Address,
) -> bool;
```

### Reward Contract

Automated XLM reward distribution for habit completion and achievements.

**Features:**
- Tiered reward calculation
- Streak multiplier system
- Reward pool management
- Anti-gaming mechanisms
- Treasury integration

**Key Functions:**
```rust
// Calculate and send reward
fn send_habit_reward(
    env: Env,
    user: Address,
    habit_id: String,
    streak_days: u32,
    completion_data: Bytes,
) -> bool;

// Update reward rates
fn update_reward_rates(
    env: Env,
    base_rate: i128,
    streak_multiplier: u32,
    admin: Address,
) -> bool;
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
    use soroban_sdk::Env;

    #[test]
    fn test_guild_creation() {
        let env = Env::default();
        let contract_id = env.register_contract(None, GuildContract {});
        let client = GuildContractClient::new(&env, &contract_id);
        
        // Test guild creation
        let guild_address = client.create_guild(
            &"Test Guild".into_val(&env),
            &vec![Address::random(&env)],
            &1000_i128,
            &vec!["Complete 5 focus sessions".into_val(&env)],
        );
        
        assert!(guild_address != Address::random(&env));
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

# Update contract registry
make update-registry-testnet
```

### Mainnet Deployment

```bash
# Deploy to mainnet (requires additional verification)
make deploy-mainnet

# Verify contracts
make verify-contracts
```

### Deployment Scripts

```bash
# Setup environment
./scripts/setup.sh

# Deploy contracts
./scripts/deploy.sh testnet

# Initialize contracts
./scripts/init.sh testnet
```

## 📊 Contract Interaction

### Using Soroban CLI

```bash
# Invoke contract
soroban contract invoke \
  --id CONTRACT_ID \
  --function create_guild \
  --arg "Test Guild" \
  --arg "[ADDRESS1,ADDRESS2]" \
  --arg 1000

# Query contract state
soroban contract read \
  --id CONTRACT_ID \
  --function get_guild_info \
  --arg GUILD_ADDRESS
```

### Using JavaScript SDK

```javascript
import { Contract } from '@stellar/stellar-sdk';

const guildContract = new Contract({
  contractId: 'CONTRACT_ID',
  networkPassphrase: 'Test SDF Network ; September 2015',
  rpcUrl: 'https://soroban-testnet.stellar.org',
});

// Create guild
const result = await guildContract.call({
  method: 'create_guild',
  args: [
    new Address('ADDRESS1'),
    'Test Guild',
    [new Address('ADDRESS1'), new Address('ADDRESS2')],
    1000
  ]
});
```

## 🔒 Security Considerations

### Audit Checklist

- [ ] Input validation and sanitization
- [ ] Access control and permissions
- [ ] Reentrancy protection
- [ ] Integer overflow/underflow
- [ ] Gas optimization
- [ ] Event logging
- [ ] Upgrade mechanisms

### Security Best Practices

- Use the latest Soroban SDK version
- Implement proper access controls
- Validate all external inputs
- Use secure random number generation
- Implement rate limiting where applicable
- Log all important state changes

## 📈 Gas Optimization

### Optimization Techniques

- Use efficient data structures
- Minimize storage operations
- Batch operations when possible
- Use events for off-chain data
- Implement caching mechanisms

### Gas Analysis

```bash
# Analyze gas usage
make analyze-gas

# Compare implementations
make benchmark-contracts
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Workflow

1. Fork the repository
2. Create a feature branch
3. Implement your contract
4. Add comprehensive tests
5. Update documentation
6. Submit a pull request

### Areas for Contribution

- **New Contracts**: Additional contract implementations
- **Optimization**: Gas and performance improvements
- **Testing**: Test coverage and test utilities
- **Documentation**: Contract documentation and examples
- **Security**: Security audits and improvements

## 📚 Resources

- [Soroban Documentation](https://soroban.stellar.org/)
- [Stellar SDK](https://github.com/stellar/js-stellar-sdk)
- [Rust Book](https://doc.rust-lang.org/book/)
- [Smart Contract Security](https://consensys.github.io/smart-contract-best-practices/)

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.
