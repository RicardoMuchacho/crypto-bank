## Bloque 5 - Crypto Bank

Projecto: Crear un banco crypto para multiples usuarios con los siguientes features:

- depositar
- retirar
- revisar balance
- checqueos de balance y maximo balance

Aditional: 

- Bank balance
- Borrowind and repaying
- Borrow Fees

### Conceptos

CEI pattern: buenas practicas para crear funciones 
  1. Checks
  2. Effects (logics)
  3. Interactions

Having state updates at the end allows malicious contract to interact with the contract before the state update, which is a critical bug called Reentrancy attack