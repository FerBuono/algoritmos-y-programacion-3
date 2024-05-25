# Mars Rover

[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/p1IUhq17)

## Introduction

As part of the NASA team developing remote exploration equipment for Mars, we need to develop a system to control the Mars Rover. The surface of Mars is assumed to be a plane, and the Mars Rover is positioned using points on this plane, along with a cardinal direction indicating where it is pointing.

Given the distance to Mars, commands are sent in batches, packaged as strings, where each character represents a command. Communication issues can result in erroneous commands, and in such cases, the Mars Rover should stop processing the remaining commands.

## Objective

- Control the Mars Rover's movements on a plane.
- Handle commands to move forward, backward, and rotate.
- Ensure erroneous commands stop further processing.

## Commands

The Mars Rover always starts at an initial point `(x, y)` and points to a cardinal direction (N, S, E, W). It receives a sequence of commands represented by characters:

- `f` = move forward one point
- `b` = move backward one point
- `l` = rotate 90 degrees to the left
- `r` = rotate 90 degrees to the right

## Implementation

### Classes and Methods

- `MarsRoverTest`: A subclass of `TestCase` containing various tests to validate the Mars Rover functionality.

#### MarsRoverTest Methods

- **assertQue:seEncuentraEnLaPosicion:apuntandoA:luegoDeRecibirLosComandos:**: Asserts the Mars Rover's position and orientation after receiving commands.
- **setUp**: Initializes the Mars Rover in different orientations.
- Various test methods to validate different commands and orientations.

### Mars Rover Model

- `MarsRover`: Controls the Mars Rover's movements and orientation.
- `OrientacionMarsRover`: Represents the orientation of the Mars Rover.

#### MarsRover Methods

- **initializeEnPosicion:apuntandoA:**: Initializes the Mars Rover's position and orientation.
- **procesarComando:**: Processes individual commands.
- **recibirComandos:**: Receives and processes a sequence of commands.
- **moverHaciaAdelante**: Moves the Mars Rover forward.
- **moverHaciaAtras**: Moves the Mars Rover backward.
- **rotarALaDerecha**: Rotates the Mars Rover to the right.
- **rotarAIzquierda**: Rotates the Mars Rover to the left.
- **orientacion**: Returns the current orientation.
- **posicionActual**: Returns the current position.

### OrientacionMarsRover Methods

- **adelante**: Subclass responsibility for moving forward.
- **rotarADerecha**: Subclass responsibility for rotating to the right.
- **rotarAIzquierda**: Subclass responsibility for rotating to the left.

### Cardinal Directions

- `Norte`, `Este`, `Oeste`, `Sur`: Subclasses of `OrientacionMarsRover` implementing direction-specific behaviors.

## Tips

In Smalltalk, points on the plane are represented by the `Point` class. Instances of `Point` can be created using the `@` message. For example, `0@0`.

## How to Run

1. Clone the repository:
   ```sh
   git clone git@github.com:FerBuono/algoritmos-y-programacion-3.git
   cd algoritmos-y-programacion-3/mars-rover
   ```
2. Ensure you have a Smalltalk environment set up.

3. Load the .st files into your Smalltalk environment and run the tests to ensure they pass without any redundant code.