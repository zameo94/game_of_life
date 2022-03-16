require 'rails_helper'

RSpec.describe GameOfLife, type: :model do
  let!(:game_of_life) { GameOfLife.new }
  let!(:path) { "storage/test.txt" }

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
    it "accept only txt" do
      expect(game_of_life.upload_txt(path)).to eq(true)
      expect(game_of_life.upload_txt("storage/test.xml")).to eq(false)
    end

    it "self.file" do
      game_of_life.upload_txt(path)

      expect(game_of_life.file).not_to eq(nil)
      expect(game_of_life.file.read).to eq("Ciaoooooooooooooo")
    end
  end
end
