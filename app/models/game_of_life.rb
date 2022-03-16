class GameOfLife
  attr_accessor :width
  attr_accessor :height
  attr_accessor :file

  def initialize
    self.width = 10
    self.height = 10
  end

  def upload_txt(path = "storage/test.txt")
    validate_file(File.open(path, "r"))
  end

  private

  def validate_file(file)
    if File.extname(file).eql? ".txt"
      self.file = file
      puts self.file.read
      true
    else
      puts "Error format"
      false
    end
  end
end
