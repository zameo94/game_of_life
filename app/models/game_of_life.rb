class GameOfLife
  attr_accessor :width
  attr_accessor :height
  attr_accessor :file
  attr_accessor :generation
  attr_accessor :error
  attr_accessor :frame

  def initialize
    self.width = 10
    self.height = 10
  end

  def run(path = "storage/test.txt")
    upload_txt(path)

    if error.nil?
      puts "Generation: #{self.generation}"
      puts "#{self.height} #{self.width}"
      puts "#{self.frame}"
    end
  end

  def upload_txt(path)
    if File.exist?(path)
      file = File.open(path, "r")
      validate_file(file)
      file.close

      unless self.file.nil?
        parse_file
      end
    else
      self.error = "File not found"
    end
  end

  private

  def validate_file(file)
    validate_extension(file)
  end

  def validate_extension(file)
    if File.extname(file).eql? ".txt"
      self.file = file.read
    else
      self.error = "Wrong file format"
    end
  end

  def parse_file
    @rows = self.file.split(/\n/)
    get_generation
    get_width
    get_height
    get_frame
  end

  def get_generation
    row = @rows[0]
    if row.include? "Generation "
      columns = row.split(":")
      self.generation = columns[0].last.to_i
    end
  end

  def get_width
    row = @rows[1]
    self.width = row[2].to_i
    self.error = 'Unable to get with' if self.width.nil?
  end

  def get_height
    row = @rows[1]
    self.height = row[0].to_i
    self.error = 'Unable to get height' if self.height.nil?
  end

  def get_frame
    frame = ""
    for i in 0...self.height
      #I sum 2 at row index 'i' for exclude the generation and width/height rows
      frame += @rows[i+2]

      #knowning which arrays start at 0, i add 1 at row index 'i' for ri-equilibrate counts,
      # so the \n is not added at the last line
      frame += "\n" unless (i + 1).eql? self.height
    end

    self.frame = frame
    self.error = 'Unable to get frame' if self.frame.nil?
  end
end
