namespace :game_of_life do
  desc "help"
  task help: :environment do
    puts "This simple Ruby on Rails console application reproduce the Conway's Game of life."
    puts "There's two simple option, you can run it using:"
    puts "game_of_life:run_sample"
    puts "game_of_life:run_sample2"
  end

  desc "Run sample"
  task run_sample: :environment do
    game_of_life = GameOfLife.new
    game_of_life.run
  end

  desc "Run sample2"
  task run_sample2: :environment do
    game_of_life = GameOfLife.new
    game_of_life.run("storage/sample2.txt")
  end
end
