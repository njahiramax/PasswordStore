
# PasswordStore: A Secure Smart Contract for Password Storage

PasswordStore allows users to securely store and retrieve passwords on the blockchain. With encryption, only the user has access to their password, ensuring complete privacy.

## Table of Contents

- [PasswordStore: A Secure Smart Contract for Password Storage](#passwordstore-a-secure-smart-contract-for-password-storage)
  - [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
    - [Requirements](#requirements)
    - [Quickstart](#quickstart)
  - [Usage](#usage)
    - [Deploy Locally](#deploy-locally)
    - [Testing](#testing)
      - [Test Coverage](#test-coverage)
  - [Audit Scope](#audit-scope)
    - [Generate Audit Report](#generate-audit-report)

---

## Getting Started

### Requirements

- **Git**: Version control for managing your code.  
  Verify with:  
  ```bash
  git --version
````

* **Foundry**: A framework for smart contract development.
  Verify with:

  ```bash
  forge --version
  ```

### Quickstart

Clone the repository and build the project:

```bash
git clone https://github.com/njahiramax/PasswordStore.git
cd PasswordStore
forge build
```

---

## Usage

### Deploy Locally

1. **Start a local Ethereum node**

   ```bash
   make anvil
   ```

2. **Deploy the contract**
   Ensure your local node is running and deploy the contract with:

   ```bash
   make deploy
   ```

### Testing

Run the tests:

```bash
forge test
```

#### Test Coverage

Generate a coverage report:

```bash
forge coverage
```

For detailed coverage debugging:

```bash
forge coverage --report debug
```

---

## Audit Scope

* **Commit Hash**: `0x5FbDB2315678afecb367f032d93F642f64180aa3`
* **Contract in Scope**:
  `./src/PasswordStore.sol`
* **Solidity Version**: 0.8.24
* **Chain**: Ethereum

### Generate Audit Report

To generate an audit report, first install dependencies from the [audit-report-templating](https://github.com/Cyfrin/audit-report-templating) repository.

```bash
cd audits
pandoc 2023-09-01-password-store-report.md -o report.pdf --from markdown --template=eisvogel --listings
```

