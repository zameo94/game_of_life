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

      self.height.times.each do |y|
        output = ""
        self.width.times.each do |x|
          output += self.frame[y][x]
        end
        puts output
      end
      true
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

  def advance_frame

    new_grid = {}

    self.width.time do |x|
      self.height.time do |y|

      end
    end

    (Window.width / SQUARE_SIZE).times do |x|
      (Window.height / SQUARE_SIZE).times do |y|
        alive = @grid.has_key?([x, y])
        alive_neightbours = [
          @grid.has_key?([x - 1, y - 1]), # Top Left
          @grid.has_key?([x, y - 1]), # Top
          @grid.has_key?([x + 1, y - 1]), # Top Right
          @grid.has_key?([x + 1, y]), # Right
          @grid.has_key?([x + 1, y + 1]), # Bottom Right
          @grid.has_key?([x, y + 1]), # Bottom
          @grid.has_key?([x - 1, y + 1]), # Bottom Left
          @grid.has_key?([x - 1, y]) # Left
        ].count(true)

        if (alive and alive_neightbours.between?(2, 3)) or (!alive and alive_neightbours.eql? 3)
          new_grid[[x, y]] = true
        end
      end
    end

    @grid = new_grid

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
    frame = Array.new(self.height) {Array.new(self.width)}

    self.height.times do |y|
      self.width.times do |x|
        frame[y][x] = @rows[y + 2][x]
      end
    end

    self.frame = frame
  end

  def get_frame_old
    frame = ""
    for i in 0...self.height
      #I sum 2 at row index 'i' for exclude the generation and width/height rows
      frame += @rows[i + 2]

      #knowning which arrays start at 0, i add 1 at row index 'i' for ri-equilibrate counts,
      # so the \n is not added at the last line
      frame += "\n" unless (i + 1).eql? self.height
    end

    self.frame = frame
    self.error = 'Unable to get frame' if self.frame.nil?
  end

end
