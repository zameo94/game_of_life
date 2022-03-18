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
    @alive_cells = {}
  end

  def run(path = "storage/test.txt")
    upload_txt(path)

    if error.nil?
      print_frame

      advance_frame
      true
    end
  end

  def print_frame
    puts "Generation: #{self.generation}"
    puts "#{self.height} #{self.width}"

    self.height.times.each do |y|
      output = ""
      self.width.times.each do |x|
        if @alive_cells.has_key?([y , x])
          output += "*"
        else
          output += "."
        end
      end
      puts output
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
    new_alive = {}
    self.height.times do |y|
      self.width.times do |x|
        alive = self.frame[y][x].eql? "*"

        alive_neightbours = [
          @alive_cells.has_key?([y - 1, x - 1]), # Top Left
          @alive_cells.has_key?([y - 1, x]), # Top
          @alive_cells.has_key?([y - 1, x + 1]), # Top Right
          @alive_cells.has_key?([y, x + 1]), # Right
          @alive_cells.has_key?([y + 1, x + 1]), # Bottom Right
          @alive_cells.has_key?([y + 1, x]), # Bottom
          @alive_cells.has_key?([y + 1, x - 1]), # Bottom Left
          @alive_cells.has_key?([y, x - 1]) # Left
        ].count(true)

        if (alive and alive_neightbours.between?(2, 3)) or (!alive and alive_neightbours.eql? 3)
          new_alive[[y, x]] = true
        end
      end
    end

    @alive_cells = new_alive

    self.generation += 1

    puts ""
    puts "-"*50
    puts ""
    print_frame
    sleep 0.5
    advance_frame
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

        if @rows[y + 2][x].eql? "*"
          @alive_cells[[y, x]] = true
        end
      end
    end

    self.frame = frame
  end
end
