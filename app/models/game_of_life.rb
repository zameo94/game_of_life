class GameOfLife
  attr_accessor :width
  attr_accessor :height
  attr_accessor :file
  attr_accessor :error

  def initialize
    self.width = 10
    self.height = 10
  end

  def upload_txt(path = "storage/test.txt")
    if File.exist?(path)
      validate_file(File.open(path, "r"))
    else
      self.error = "File not found"
      false
    end
  end

  private

  def validate_file(file)
    if File.extname(file).eql? ".txt"
      self.file = file
      true
    else
      self.error = "Wrong file format"
      false
    end
  end
end
