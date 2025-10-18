# Conway's Game of Life

A Ruby implementation of Conway's Game of Life, a cellular automaton that simulates the evolution of a grid of cells based on simple mathematical rules.

## About the Game

Conway's Game of Life is a zero-player game, meaning that its evolution is determined by its initial state, requiring no further input. The universe consists of a two-dimensional grid of cells, each of which can be either alive or dead. The simulation evolves in discrete time steps according to these rules:

1. **Underpopulation**: Any live cell with fewer than two live neighbors dies
2. **Survival**: Any live cell with two or three live neighbors lives on to the next generation
3. **Overpopulation**: Any live cell with more than three live neighbors dies
4. **Reproduction**: Any dead cell with exactly three live neighbors becomes a live cell

## Features

- 20x20 grid with wraparound edges (toroidal topology)
- Real-time animated simulation
- Starts with a predefined "Battleship" pattern
- Interactive controls to stop the simulation
- Generation counter to track evolution steps
- 0.5-second delay between generations for easy viewing

## Prerequisites

- Ruby (tested with Ruby 3.3.0)
- The `io/console` library (included in Ruby standard library)

## Installation

1. Clone this repository:
```bash
git clone https://github.com/zameo94/game_of_life.git
cd game_of_life
```

2. No additional dependencies required - uses only Ruby standard library!

## Usage

Run the simulation:

```bash
ruby game_of_life.rb
```

### Controls

- **Press 's'** during the simulation to stop and exit
- The simulation will automatically advance through generations every 0.5 seconds

### Display

- `*` represents a living cell
- `.` represents a dead cell
- Each generation is numbered and displayed with border lines

## Initial Pattern

The simulation starts with a "Battleship" pattern, which is a well-known configuration in Game of Life that creates an interesting evolution sequence.

## Technical Details

- **Grid Size**: 20x20 cells
- **Topology**: Toroidal (edges wrap around)
- **Timing**: 0.5 seconds between generations
- **Input Handling**: Non-blocking character input for user control

## Example Output

```
--------------------------------------------------
You can stop the simulation by pressing the key s
Generation: 0
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . * * * *
. . . . . . . . . . . . . . . * . . . *
. . . . . . . . . . . . . . . . . . . *
. . . . . . . . . . . . . . . * . . * .
. . . . . . . . . . . . . . . . . . . .
--------------------------------------------------
```

## Contributing

Feel free to fork this project and submit pull requests for improvements such as:

- Different initial patterns
- Adjustable grid sizes
- Color support
- Pattern loading from files

## License

This project is open source and available under the MIT License.

## Learn More

- [Conway's Game of Life - Wikipedia](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
- [LifeWiki - Patterns and Rules](https://conwaylife.com/)