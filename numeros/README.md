# Números

[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/ZAxPycRi)

## Introduction

The purpose of this exercise is to refactor the provided code to eliminate any redundant code found in both the model and the tests. The model represents numbers and supports operations on integers and fractions.

## Objective

- Identify and eliminate redundant code in the model and tests.
- Maintain the functionality and correctness of the tests.
- Implement additional arithmetic operations and the Fibonacci sequence.
- Remove `if` statements by using polymorphism.

## First Part

1. File-in the `Numeros-Parte1-Ejercicio.st` file.
2. The provided class `Numero` represents a model of numbers, supporting integer and fraction operations.
3. The suite of tests verifies basic operations supported by the model.
4. The goal is to remove `if` statements using polymorphism, applying the algorithm discussed in class.
5. Ensure all tests continue to pass without modifying them.

## Second Part

1. Remove the category `Numeros-Parte1-Ejercicio` and then **file-in** `Numeros-Parte2-Ejercicio.st`.
2. This model is a possible solution to the first part, with added operations: subtraction, division, and Fibonacci.
3. Some tests fail because they involve operations between different types of numbers (integers and fractions).
4. Implement addition, subtraction, multiplication, and division between integers and fractions.
5. Ensure the final solution has no `if` statements in the methods and all tests pass without modifications.

## Fibonacci

1. Take the replacement of `if` statements to the extreme by removing `if` statements from the `#fibonacci` method.
2. The solution should use polymorphism to replace `if` statements.

## Steps to Follow

1. Debug the tests that work to understand the presented model. Analyze the classes `Numero`, `Entero`, and `Fraccion`.
2. Implement the necessary changes using `if` statements until all tests pass.
3. Replace the `if` statements with polymorphism using the algorithm discussed in class.
4. Apply the same techniques to remove `if` statements from `#fibonacci`.

## Additional Challenge (Optional)

1. Remove any remaining `if` statements initially present in the exercise (e.g., handling zero division, ensuring the denominator is not one).
2. Implement solutions using patterns like double dispatch, dependency injection, or abstract factory.

## Theoretical Questions

### Contribution of DD Messages

1. **How many polymorphic messages participate in a double dispatch (DD)? What information does each provide?**

   **Answer:**
   Two polymorphic messages participate in double dispatch. The first message is sent to the receiver object, determining its type. The second message is sent to the argument object, determining its type as well.

### Instantiation Logic

1. **Where is it best to place the logic for instantiating an object? Why? If the object is created from different places and in different ways, how do you solve it?**

   **Answer:**
   Instantiating an object should be implemented in one place to maintain single responsibility and consistency. This can be achieved in a constructor method. If created from different places, dependency injection can be used, or the abstract factory pattern can handle different subtypes' creation based on their characteristics.

### Method Category Names

1. **What criteria are you using to categorize methods? How do you differentiate the external protocol from internal use messages?**

   **Answer:**
   Public methods are available for object instances to interact with them. Class methods encapsulate the object's functionality and complexity (private methods). Internal messages are used within a class, whereas the external protocol involves interaction between classes.

### Subclass Responsibility

1. **If all subclasses know how to respond to the same message, why do we put that message only with "self subclassResponsibility" in the superclass? What purpose does it serve? What happens if we don't?**

   **Answer:**
   The "self subclassResponsibility" message redirects the same message to subclasses, allowing different implementations through polymorphism. Without it, the method would require many `if` statements, or a subclass might not implement the method, causing runtime errors.

### Encapsulation

1. **Why is breaking encapsulation problematic?**

   **Answer:**
   Breaking encapsulation allows external access to implementation details, increasing coupling and risking errors when accessing internal states. It complicates code evolution, introduces unwanted dependencies, and reduces modularity.

## How to Run

1. Clone the repository:
   ```sh
   git clone git@github.com:FerBuono/algoritmos-y-programacion-3.git
   cd algoritmos-y-programacion-3/numeros
    ```
2. Ensure you have a Smalltalk environment set up.

3. Load the .st files into your Smalltalk environment and run the tests to ensure they pass without any redundant code.