require 'rails_helper'

RSpec.describe GameOfLife, type: :model do
  let(:game_of_life) { GameOfLife.new }
  let!(:path) { "storage/sample.txt" }

  context "GameOfLife" do
    it "must have width & height" do
      expect(game_of_life.width.present?).to eq(true)
      expect(game_of_life.height.present?).to eq(true)
    end

    it "10 as default width & height" do
      expect(game_of_life.width).to eq(10)
      expect(game_of_life.height).to eq(10)
    end
  end

  context "upload_txt" do
    it "upload txt" do
      game_of_life.upload_txt(path)
      expect(game_of_life.error).to eq(nil)
    end

    it "upload not txt" do
      game_of_life.upload_txt("storage/test.xml")
      expect(game_of_life.error).to eq("Wrong file format")
    end

    it "file not found" do
      game_of_life.upload_txt("storage/test.aaa")
      expect(game_of_life.error).to eq("File not found")
    end

    it "self.file" do
      game_of_life.upload_txt(path)

      expect(game_of_life.file).not_to eq(nil)
      expect(game_of_life.file).to eq("Generation 3:\n4 8\n........\n....*...\n...**...\n........")
    end
  end

  context "sample.txt" do
    it "self.generation" do
      game_of_life.upload_txt("storage/sample.txt")

      expect(game_of_life.generation).not_to eq(nil)
    end

    it "get_generation" do
      my_generation = 3
      game_of_life.upload_txt("storage/sample.txt")

      expect(game_of_life.generation).to eq(my_generation)
    end

    it "get_width" do
      my_width = 8
      game_of_life.upload_txt("storage/sample.txt")

      expect(game_of_life.width).to eq(my_width)
      expect(game_of_life.error).to eq(nil)
    end

    it "get_height" do
      my_height = 4
      game_of_life.upload_txt("storage/sample.txt")

      expect(game_of_life.height).to eq(my_height)
      expect(game_of_life.error).to eq(nil)
    end

    it "get_frame" do
      my_frame = "........\n....*...\n...**...\n........"
      game_of_life.upload_txt("storage/sample.txt")

      expect(game_of_life.frame).to eq(my_frame)
      expect(game_of_life.error).to eq(nil)
    end
  end
end
