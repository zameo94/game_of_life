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
      expect(game_of_life.width).to eq(0)
      expect(game_of_life.height).to eq(0)
    end
  end

  context "upload_txt" do
    it "upload txt" do
      game_of_life.upload_txt(path)
      expect(game_of_life.errors).to eq('')
    end

    it "upload not txt" do
      game_of_life.upload_txt("spec/files/test.xml")
      expect(game_of_life.errors).to eq("Wrong file format. ")
    end

    it "file not found" do
      game_of_life.upload_txt("storage/test.aaa")
      expect(game_of_life.errors).to eq("File not found. ")
    end

    it "self.file" do
      game_of_life.upload_txt(path)

      expect(game_of_life.file).not_to eq(nil)
      expect(game_of_life.file).to eq("Generation 3:\n4 8\n........\n....*...\n...**...\n........")
    end
  end

  context "sample.txt" do
    it "self.generation" do
      game_of_life.upload_txt(path)

      expect(game_of_life.generation).not_to eq(nil)
    end

    it "get_generation" do
      my_generation = 3
      game_of_life.upload_txt(path)

      expect(game_of_life.generation).to eq(my_generation)
    end

    it "get_width" do
      my_width = 8
      game_of_life.upload_txt(path)

      expect(game_of_life.width).to eq(my_width)
      expect(game_of_life.errors).to eq("")
    end

    it "get_height" do
      my_height = 4
      game_of_life.upload_txt(path)

      expect(game_of_life.height).to eq(my_height)
      expect(game_of_life.errors).to eq("")
    end

    it "alive_cells" do
      my_alive_cells = {[1, 4]=>true, [2, 3]=>true, [2, 4]=>true}
      game_of_life.upload_txt(path)

      expect(game_of_life.alive_cells).to eq(my_alive_cells)
      expect(game_of_life.errors).to eq("")
    end

    it "recalculate_alive_cells" do
      my_new_gen_alive_cells = {[1, 3]=>true, [1, 4]=>true, [2, 3]=>true, [2, 4]=>true}
      game_of_life.upload_txt(path)
      game_of_life.send(:recalculate_alive_cells)

      expect(game_of_life.alive_cells).to eq(my_new_gen_alive_cells)
      expect(game_of_life.errors).to eq("")
    end
  end

  context "error" do
    it "width_height row not present" do
      game_of_life.upload_txt("spec/files/test2.txt")

      expect(game_of_life.errors).to eq("Width & height's row not present. ")
    end

    it "width_height not present" do
      game_of_life.upload_txt("spec/files/test.txt")

      expect(game_of_life.errors).to eq("Unable to get width & height. ")
    end

    it "generation not present" do
      game_of_life.upload_txt("spec/files/test3.txt")

      expect(game_of_life.errors).to eq("Unable to find generation. ")
    end

    it "uncorrected generation's row" do
      game_of_life.upload_txt("spec/files/test4.txt")

      expect(game_of_life.errors).to eq("Unable to find generation. Width & height's row not present. ")
    end

    it "empty file" do
      game_of_life.upload_txt("spec/files/empty.txt")

      expect(game_of_life.errors).to eq("Unable to upload file. ")
    end
  end
end
