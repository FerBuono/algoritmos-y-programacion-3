# Servicios Financieros

[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/A04Akb2N)

## Introduction

A bank wants to offer new services to its customers and has hired us to extend its current system. The existing system includes a simple banking model consisting of bank accounts and deposit and withdrawal transactions. This model can be loaded by doing a file-in of `ServiciosFinancieros-Ejercicio.st`.

## Objectives

1. Implement transfer services between accounts.
2. Implement portfolios to manage groups of accounts.

## Transfers

A **transfer** is a transaction between accounts that has two "legs": the **extraction leg**, where the money is taken from, and the **deposit leg**, where the money is deposited.

### Requirements

- Register a transfer between accounts.
- Determine the value of the transfer.
- Query each leg of the transfer for its counterpart (e.g., the extraction leg should know the related deposit leg and vice versa).

### Implementation

- Implement the transfer model using TDD.
- Correct any failing tests before beginning the modeling of transfers.

## Portfolios

Portfolios are groupings of accounts, referred to as **portfolios**. They allow similar operations as a conventional account, except for registering transactions. For instance, obtaining the balance of a portfolio that includes Account 1 (with a balance of $100) and Account 2 (with a balance of $200) should result in a balance of $300.

### Requirements

- Get the balance of a portfolio.
- Check if any account within the portfolio has registered a transaction.
- Retrieve all transactions of a specific account within the portfolio.
- Portfolios can be composed of both conventional accounts and other portfolios.
- Ensure the above operations work correctly for nested portfolios.

### Implementation

- Implement the portfolio model using TDD.

## Extra: Valid Portfolios

Portfolios should avoid duplication of information by ensuring:

1. A portfolio cannot add the same account twice.
2. A portfolio cannot add an account already included in a previously added portfolio.
3. A portfolio cannot include itself.
4. An account cannot be added to a portfolio if the portfolio is already part of another portfolio that includes the account.
5. A portfolio cannot add another portfolio if the latter includes an account that the former already has.

### Implementation

- Extend the existing model to include these constraints.

## How to Run

1. Clone the repository:
   ```sh
   git clone git@github.com:FerBuono/algoritmos-y-programacion-3.git
   cd algoritmos-y-programacion-3/servicios-financieros
   ```
2. Ensure you have a Smalltalk environment set up.

3. Load the .st files into your Smalltalk environment and run the tests to ensure they pass without any redundant code.