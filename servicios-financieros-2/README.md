# Servicios Financieros 2

[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/16u_Tlot)

## Introduction

Due to our excellent work, the CEO of the bank decided to extend our contract and add more functionalities. This time, the focus is on providing reporting capabilities for customer accounts and portfolios.

## Objectives

1. Implement account summaries.
2. Implement transfer net reports.
3. Implement portfolio tree and detailed tree reports.
4. Ensure the solution is extensible for future report additions without modifying existing hierarchies.

## Reports

### Account Summary

The **account summary** generates a line for each transaction performed on an account in the following format:
```st
Deposito por 100 pesos
Extraccion por 50 pesos
Salida por transferencia de 20 pesos
Entrada por transferencia de 30 pesos
Balance = 60 pesos
```

This is the expected account summary for an account with a deposit of 100, a withdrawal of 50, a transfer out of 20, and a transfer in of 30, resulting in a balance of 60.

### Transfer Net

The **transfer net** report calculates the net result of adding all transfer deposits and subtracting all transfer withdrawals. For the example above, the transfer net would be 10.

### Portfolio Tree

The **portfolio tree** report shows the complete tree structure of the portfolio. Given the following portfolio setup:

```st
johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
myAccount := ReceptiveAccount named: 'Cuenta mia'.
familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
```

The tree report should look like:

```
Portfolio de la familia
Cuenta mia
Portfolio de hijos
Cuenta de Juan
Cuenta de Angeles
```

### Portfolio Detailed Tree

The **portfolio detailed tree** report shows the transactions indented according to the depth of each account in the portfolio. The detailed tree report for the example portfolio should be:

```
Portfolio de la familia
Cuenta Mia
Depósito por xxx
Extracción por yyy
Balance = bbb
Portfolio de hijos
Cuenta de Juan
Depósito por zzz
Extracción por nnn
Balance = bbb
Cuenta de Angeles
Salida por transferencia de qqq
Balance = bbb
Balance = bbb
Balance = bbb
```


## Requirements for Extensibility

1. Future reports should be added without modifying the account hierarchy.
2. Future reports should be added without modifying the transaction hierarchy.
3. Creating new reports should involve creating new classes only, without modifying existing ones.

## Implementation

- Use Test-Driven Development (TDD) for implementing the solution.
- Ensure the solution is designed to support adding new reports by simply creating new classes.

## How to Run

1. Clone the repository:
   ```sh
   git clone git@github.com:FerBuono/algoritmos-y-programacion-3.git
   cd algoritmos-y-programacion-3/servicios-financieros-2
   ```
2. Ensure you have a Smalltalk environment set up.

3. Load the .st files into your Smalltalk environment and run the tests to ensure they pass without any redundant code.