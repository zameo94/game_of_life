require 'rails_helper'

RSpec.describe GameOfLife, type: :model do
  let(:game_of_life) { GameOfLife.new }

  context "test game od life rule" do
    it "must have width & height" do
      expect(game_of_life.width.present?).to eq(true)
      expect(game_of_life.height.present?).to eq(true)
    end

    it "10 as default width & height" do
      expect(game_of_life.width).to eq(10)
      expect(game_of_life.height).to eq(10)
    end
  end
end
