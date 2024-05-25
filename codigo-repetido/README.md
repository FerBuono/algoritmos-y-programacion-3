# Código Repetido

[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/b7RHcF4-)

## Introduction

The purpose of this exercise is to refactor the provided code to eliminate any redundant code found in both the model and the tests. For example, there is repetitive code between `test01` and `test02`.

The provided tests already function correctly; the goal is to remove the redundant code while ensuring the tests continue to work as expected.

## Objective

- Identify and eliminate redundant code in the model and tests.
- Maintain the functionality and correctness of the tests.
- Modify the provided classes only to remove redundant code, without altering the tests' assertions or functionality.

## Clarifications

- For simplicity, a `Customer` is modeled using a `String` instead of a `Customer` class. The objective is not to correct this decision or its consequences (e.g., not being able to add two different `Customers` with the same name to the `CustomerBook`).

## Implementation

### Classes and Methods

- `CantSuspend`: An error subclass to handle suspension errors.
- `NotFound`: An error subclass to handle not found errors.
- `CustomerBookTest`: A subclass of `TestCase` containing various tests to validate the `CustomerBook` functionality.

#### CustomerBookTest Methods

- **test01AddingCustomerShouldNotTakeMoreThan50Milliseconds**: Verifies that adding a customer does not exceed 50 milliseconds.
- **test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds**: Verifies that removing a customer does not exceed 100 milliseconds.
- **test03CanNotAddACustomerWithEmptyName**: Ensures that a customer with an empty name cannot be added.
- **test04CanNotRemoveAnInvalidCustomer**: Ensures that removing a non-existent customer raises an error.
- **test05SuspendingACustomerShouldNotRemoveItFromCustomerBook**: Checks that suspending a customer does not remove them from the `CustomerBook`.
- **test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook**: Verifies that removing a suspended customer actually removes them from the `CustomerBook`.
- **test07CanNotSuspendAnInvalidCustomer**: Ensures that suspending a non-existent customer raises an error.
- **test08CanNotSuspendAnAlreadySuspendedCustomer**: Ensures that suspending an already suspended customer raises an error.

### Questions

#### Abstraction of Tests 01 and 02

In tests 01 and 02, there is redundant code. When extracted, something new was created. This entity was present in reality but not represented in the code, leading to redundant code. The entity created is a millisecond counter that checks if the time taken is less than the specified parameter.

#### Representing in Smalltalk

Entities from reality can be represented in Smalltalk using:
- Objects, which are the entities.
- Messages, which operate on the objects.
- Classes, which represent the entities from reality.

#### Theory of Naur

Removing redundant code by creating abstractions relates to Naur's theory of the model/system. It exemplifies constructing a system theory, creating simplified representations of the same entities.

## How to Run

1. Clone the repository:
    ```sh
    git clone git@github.com:FerBuono/algoritmos-y-programacion-3.git
    cd algoritmos-y-programacion-3/codigo-repetido
    ```
2. Ensure you have a Smalltalk environment set up.

3. Load the .st files into your Smalltalk environment and run the tests to ensure they pass without any redundant code.