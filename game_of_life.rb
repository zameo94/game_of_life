require 'io/console'

ALIVE = '*'
DEAD = '.'

def alive_neighbors_counter(grid, row_key, column_key)
  counter = 0
  previous_row = (row_key - 1) % grid.size
  next_row = (row_key + 1) % grid.size
  previous_col = (column_key - 1) % grid[0].size
  next_col = (column_key + 1) % grid[0].size

  neighbors = [
    [previous_row, previous_col], [previous_row, column_key], [previous_row, next_col],
    [row_key, previous_col], [row_key, next_col],
    [next_row, previous_col], [next_row, column_key], [next_row, next_col]
  ]

  neighbors.each do |row, column|
    if grid[row][column] == ALIVE
      counter += 1
    end
  end

  counter
end

def is_alive(grid, row_key, column_key)
  live_cell_counter = alive_neighbors_counter(grid, row_key, column_key)

  if grid[row_key][column_key] == ALIVE
    return live_cell_counter == 2 || live_cell_counter == 3
  else
    return live_cell_counter == 3
  end
end

def set_cell(grid, row_key, column_key)
  if is_alive(grid, row_key, column_key)
    return ALIVE
  else
    return DEAD
  end
end

def next_generation_grid(grid)
  new_grid = Array.new(grid.size) { Array.new(grid[0].size, DEAD) }

  grid.each_with_index do |row, i|
    row.each_with_index do |column, k|
      new_grid[i][k] = set_cell(grid, i, k)
    end
  end

  new_grid
end

def battleship_shape(grid)
    # Row 5
  grid[5][16] = ALIVE
  grid[5][17] = ALIVE
  grid[5][18] = ALIVE
  grid[5][19] = ALIVE

  # Row 6
  grid[6][15] = ALIVE
  grid[6][19] = ALIVE

  # Row 7
  grid[7][19] = ALIVE

  # Row 8
  grid[8][15] = ALIVE
  grid[8][18] = ALIVE

  grid
end

def print_grid(generation, grid)
  puts('-' * 50) 
  puts('You can stop the simulation by pressing the key s')
  puts("Generation: #{generation}")
  grid.each do |row|
    puts(row.join(" "))
  end
  puts('-' * 50) 
end

def main
  grid = Array.new(20) { Array.new(20, DEAD) }
  generation = 0

  grid = battleship_shape(grid)

  while true
    print_grid(generation, grid)

    input = STDIN.getch(min: 0, time: 0.01) 
    
    if input == 's'
      puts "\nSimulation stopped by user"
      break
    end

    grid = next_generation_grid(grid)
    generation += 1

    sleep(0.5)
  end
end

main if __FILE__ == $0