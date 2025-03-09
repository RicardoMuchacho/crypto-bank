// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24;

contract CryptoBank {
   address owner;
   uint256 private bankBalance;
   mapping(address user => uint256 balance) public userBalance;
   mapping(address user => uint256 loan) private userLoan;
   uint256 public maxValue = 10 ether;

   constructor() payable {
      bankBalance = msg.value;
      owner = msg.sender;
   }

   event depositEvent(address account, uint256 amount);
   event withdrawEvent(address account, uint256 amount);
   event borrowEvent(address account, uint256 amount);
   event repayEvent(address account, uint256 amount, uint256 refundAmount);
   event valueCheck(uint256 value);

   modifier onlyOwner() {
     require(msg.sender == owner, "Not Owner");
     _;
   }

   function deposit() external payable {
      require(msg.value + userBalance[msg.sender] <= maxValue, "Max ETH Exceeded");
      userBalance[msg.sender] += msg.value;

      emit depositEvent(msg.sender, msg.value);
   }
   
   function withdraw(uint256 amount) external {
      //checks
      require(userLoan[msg.sender] == 0, "Loan not repayed");
      require(userBalance[msg.sender] >= amount, "Not enough balance");

      //effects
      userBalance[msg.sender] -= amount;

      //interactions with state
      (bool success, )  = msg.sender.call{value: amount}("");
      require(success, "Failed");

      emit withdrawEvent(msg.sender, amount);
   } 

   // allows borrowing up to 50% of the user balance with 5% interest on repay
   function borrow(uint256 amount) external {
     require(amount <= userBalance[msg.sender]/2, "Not enough collateral");
     require(userLoan[msg.sender] == 0, "Repay Loan to borrow again");
     require(bankBalance > amount, "Out of ETH to borrow");

     bankBalance -= amount;
     userLoan[msg.sender] += (amount * 105) / 100;

     (bool success , ) = msg.sender.call{value: amount}("");
     if (!success) revert();

      emit borrowEvent(msg.sender, amount);
   }

   function repayLoan() external payable {
     uint256 loanAmount = userLoan[msg.sender];

     require(loanAmount > 0, "No loan");
     require(msg.value >= loanAmount, "Not enough to repay");

     uint256 overPay = msg.value - loanAmount;

     (bool successReturn,) = msg.sender.call{value: overPay}("");
     if (!successReturn) revert();

   //   emit valueCheck(userLoan[msg.sender]);
     bankBalance += loanAmount;
     userLoan[msg.sender] = 0;
   //   emit valueCheck(userLoan[msg.sender]);

     emit repayEvent(msg.sender, loanAmount, overPay);
   }

   function changeMaxValue(uint256 amount) external onlyOwner{
     maxValue = amount;
   }

   function checkLoan() external view returns(uint256) {
     return userLoan[msg.sender];
   }

    function checkBankBalance() external view onlyOwner returns(uint256) {
       return bankBalance;        
    }

    receive() external payable {
      require(msg.value + userBalance[msg.sender] <= maxValue, "Max ETH Exceeded");
      userBalance[msg.sender] += msg.value;

      emit depositEvent(msg.sender, msg.value);
   }
}