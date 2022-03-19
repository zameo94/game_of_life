namespace :game_of_life do
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
