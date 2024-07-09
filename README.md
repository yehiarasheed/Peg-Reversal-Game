# Peg Reversal Game
## Project Description

### Objective
Implement a single-player board game in Haskell where the player flips the color of pegs on a board shaped like a '+'. The game starts with all pegs black except one white peg, and the goal is to turn all pegs white by flipping neighboring black pegs.

### Board Configuration
The board is shaped like a '+' with the center at position (0,0). Peg positions are relative to this center.
![image](https://github.com/yehiarasheed/Peg-Reversal-Game/assets/157399068/450db9a0-f57d-49e7-99a3-42b81d48b968)

### Rules
1. All pegs start as black except one randomly placed white peg.
2. A black peg can be flipped to white if it has at least one white neighboring peg (up, down, left, or right, but not diagonally).
3. The player wins by flipping all pegs to white.

## Implementation Details

### Type Definitions
```haskell
type Position = (Int, Int)
data Color = W | B deriving (Eq, Show)
data Peg = Peg Position Color deriving (Eq, Show)
data Move = M Position deriving (Eq, Show)
type Board = [Peg]
data State = S Move Board deriving (Eq, Show)
```

1. **Position**: Represents the position of pegs on the board with (column, row) coordinates.
2. **Color**: Represents the color of the pegs (W for white, B for black).
3. **Peg**: Represents a piece on the board with its position and color.
4. **Move**: Represents a move to flip a peg to white at a specific position.
5. **Board**: Represents the game board as a list of pegs.
6. **State**: Represents the game state with the current move and the board configuration.

### Required Functions

1. **createBoard :: Position -> Board**
   - Initializes the board with all black pegs except for one white peg at the specified position.
   - Returns an error if the position is not on the board.
   - Example:
     ```haskell
     > createBoard (1, 1)
     [Peg (-3,-1) B, Peg (-3,0) B, ..., Peg (1,1) W, ..., Peg (3,1) B]
     ```

2. **isValidMove :: Move -> Board -> Bool**
   - Checks if a move is legal.
   - A move is valid if the peg at the specified position is black and has at least one white neighboring peg.
   - Example:
     ```haskell
     > isValidMove (M (1,0)) [Peg (0,0) W, Peg (1,0) B, ...]
     True
     ```

3. **isGoal :: Board -> Bool**
   - Checks if all pegs on the board are white.
   - Example:
     ```haskell
     > isGoal [Peg (0,0) W, Peg (1,0) W, ...]
     True
     ```

4. **showPossibleNextStates :: Board -> [State]**
   - Generates all possible game states from the current board state by applying valid moves.
   - Returns an error if the board is already in a winning state.
   - Example:
     ```haskell
     > showPossibleNextStates [Peg (0,0) W, Peg (1,0) B, ...]
     [S (M (1,0)) [Peg (0,0) W, Peg (1,0) W, ...], ...]
     ```

### Error Handling
- **createBoard**: Displays an error if the specified position is not valid.
  ```haskell
  > createBoard (-2,2)
  Program error: The position is not valid.
  ```
- **showPossibleNextStates**: Displays an error if the board is already in a winning state.
  ```haskell
  > showPossibleNextStates [Peg (0,0) W, Peg (1,0) W, ...]
  Program error: No Possible States Exist.
  ```
## How to Install

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yehiarasheed/Peg-Reversal-Game.git
   cd Peg-Reversal-Game
   ```
   This command downloads a copy of the repository to your local machine and navigates into the project directory.

2. **Install WinHugs:**
   Download and install WinHugs from the [Haskell website](https://www.haskell.org/hugs/). WinHugs is the recommended Haskell compiler/interpreter for this project.

3. **Open the Project:**
   - Launch WinHugs.
   - Load the project files by navigating to `File → Open` and selecting the Haskell file you want to run.

## Dependencies

This project requires the following dependencies:

- **WinHugs**: The recommended Haskell compiler/interpreter for running the Peg Reversal Game.

Ensure WinHugs is installed and properly configured on your machine to run the Haskell code in this project.

---
