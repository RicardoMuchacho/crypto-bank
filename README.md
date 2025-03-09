# Crypto Bank 💰

Smart contract with secure banking functionalities such as deposit, withdrawal, loan management, and more.

## Features 🚀

### 🔹 Core Features

| Feature        | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| **Deposit**    | Users can deposit ETH into their CryptoBank account up to a maximum limit.  |
| **Withdraw**   | Users can withdraw ETH from their account as long as they have no outstanding loans. |
| **Check Balance** | Users can check their current balance directly from the contract.         |

### 🔹 Additional Features

| Feature                     | Description                                                                                                                                      |
|-----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| **Bank Balance**            | The contract owner can view the total ETH held by the bank.                                                                                     |
| **Borrowing and Repaying**  | Users can borrow up to 50% of their account balance with a 5% interest fee. Loans must be fully repaid before further transactions.            |
| **Borrow Fees (5%)**        | A 5% interest fee is automatically added to the loan repayment.                                                                                 |
| **Security Checks**         | The contract integrates key security measures such as reentrancy protection using effective state updates and owner-only functions.              |

### Deployment ⚙️

Deploy the contract with an initial ETH value to establish the bank's starting balance.

> [!TIP]
> Use Remix web IDE to deploy and test the smart contract

## Events

| Event Signature                                                     | Description                                   |
|---------------------------------------------------------------------|-----------------------------------------------|
| `depositEvent(address account, uint256 amount)`                     | Emitted when a deposit is made.               |
| `withdrawEvent(address account, uint256 amount)`                    | Emitted when a withdrawal is performed.       |
| `borrowEvent(address account, uint256 amount)`                      | Emitted when a loan is borrowed.              |
| `repayEvent(address account, uint256 amount, uint256 refundAmount)`   | Emitted when a loan is repaid (includes any refund amount). |

## Security Considerations

- All critical actions like changing max deposit limits are restricted to the contract owner.
- Reentrancy attacks are mitigated by updating state before external calls.
- Proper `require` statements ensure only valid transactions proceed.
