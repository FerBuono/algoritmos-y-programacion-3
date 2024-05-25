# Stack Exercise

[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/bsawMXWq)

## Introduction

In this exercise, you will implement and test a stack (LIFO) data structure. The project is divided into three parts:

1. **Preludio:** An optional but highly recommended warm-up to implement a basic stack.
2. **Main Exercise:** Re-implement the stack from scratch based on provided tests.
3. **Extensions:** Enhance the stack to handle additional constraints and functionalities.

## Preludio (Optional)

### Objective

Implement a basic stack and ensure it passes the provided tests.

### Instructions

1. **Setup:**
   - Perform a file-in of the `Stack-Preludio.st` file.
   - Observe the single failing test and the provided list of features to implement.

2. **Required Features:**
   - Ability to push an element onto the stack.
   - Ability to pop an element from the stack.
   - Ensure `pop` returns the last pushed element.
   - Ensure the stack follows LIFO (Last In, First Out) order.
   - Ability to view the last element without removing it (`top`).

3. **Implementation:**
   - Implement each feature iteratively.
   - Use simple if-statements initially to pass the tests.
   - Refactor the code to remove if-statements where possible.

## Main Exercise

### Objective

Re-implement the stack and make all provided tests pass.

### Instructions

1. **Setup:**
   - File out the `Stack-Preludio` package and save it.
   - Delete the `Stack-Preludio` package from your environment.
   - Perform a file-in of the `Stack-Exercise.st` file.

2. **Initial Tests:**
   - Some tests will initially fail. Your task is to make them pass by re-implementing the stack.

3. **Tips:**
   - Start with simple if-statements to pass the tests.
   - Apply techniques to refactor and remove if-statements.

## Second Part

### Objective

Implement the `find` method in `SentenceFinderByPrefix` to find sentences with a specific prefix in the stack.

### Requirements

1. **Prefix Search:**
   - The `find` method should return all sentences in the stack that begin with the given prefix.
   - The prefix is case-sensitive, cannot be empty, and cannot contain spaces.
   - The stack must maintain the same order of sentences after the search.

2. **Tests:**
   - Write tests for the `find` method in `SentenceFinderByPrefixTest`.

### Implementation

1. **Setup:**
   - Create instances of `SentenceFinderByPrefix` with test stacks.
   - Implement the `find` method.

2. **Testing:**
   - Ensure comprehensive test coverage for various scenarios.

## Extra (Optional)

### Objective

Extend the stack model to support a limited capacity stack.

### Requirements

1. **Limited Capacity Stack:**
   - Create a stack that has a fixed number of cells.
   - Prevent pushing more elements than the stack's capacity allows.

2. **Analysis and Implementation:**
   - Analyze which model is simpler to extend.
   - Implement the limited capacity stack based on your analysis.

3. **Testing:**
   - Write additional tests to cover the new stack type.

## Implementation Details

### Classes and Methods

1. **OOStack:**
   - `isEmpty`: Check if the stack is empty.
   - `pop`: Remove and return the last element.
   - `push`: Add an element to the stack.
   - `size`: Return the number of elements in the stack.
   - `top`: Return the last element without removing it.
   - `checkIfStackIsEmpty`: Raise an error if the stack is empty.
   - `updateState`: Update the state of the stack.

2. **SentenceFinderByPrefix:**
   - `find`: Return sentences starting with the given prefix.
   - `initializeWith`: Initialize with a stack.

3. **State, EmptyState, NotEmptyState:**
   - Handle stack state transitions and errors.

## Conclusion

By following these steps and guidelines, you will successfully implement and extend a stack data structure, ensuring it meets various requirements and handles different scenarios robustly. Happy coding!
