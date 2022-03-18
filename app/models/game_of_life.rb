class GameOfLife
  attr_accessor :width
  attr_accessor :height
  attr_accessor :file
  attr_accessor :generation
  attr_accessor :error
  attr_accessor :alive_cells

  def initialize
    self.width = 0
    self.height = 0
    self.error = ''
    self.alive_cells = {}
  end

  def run(path = "storage/test.txt")
    self.alive_cells = {}
    self.error = ''
    upload_txt(path)

    return self.error unless self.error.empty?
    print_frame
    sleep 0.5
    advance_frame
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
      self.error += "File not found. "
    end
  end

  def print_frame
    puts "Generation: #{self.generation}"
    puts "#{self.height} #{self.width}"

    self.height.times.each do |y|
      output = ""
      self.width.times.each do |x|
        if self.alive_cells.has_key?([y, x])
          output += "*"
        else
          output += "."
        end
      end
      puts output
    end
  end

  def advance_frame
    recalculate_alive_cells
    self.generation += 1

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
      self.error += "Wrong file format. "
    end
  end

  def parse_file
    @rows = self.file.split(/\n/)
    get_generation
    get_width_height
    get_alive_cells if self.error.empty?
  end

  def get_generation
    row = @rows[0]
    if row.include? "Generation "
      columns = row.split(":")
      self.generation = columns[0].last.to_i
    else
      self.error += "Unable to find generation. "
    end
  end

  def get_width_height
    row = @rows[1]

    if row.nil?
      self.error += "Unable to get width & height. "
    else
      if (row[0].to_i > 0) and (row[2].to_i > 0)
        self.width = row[2].to_i
        self.height = row[0].to_i
      else
        self.error += "Unable to get width & height. "
      end
    end
  end

  def get_alive_cells
    frame = Array.new(self.height) { Array.new(self.width) }

    self.height.times do |y|
      self.width.times do |x|
        # sum y + 2 for compensate the first & second file's lines
        frame[y][x] = @rows[y + 2][x]

        # @alice_cells contain the coordination of all live cells, used to advance the frame
        if @rows[y + 2][x].eql? "*"
          self.alive_cells[[y, x]] = true
        end
      end
    end

    self.error += "Unable to get alive_cells\n" if self.alive_cells.empty?
  end

  def recalculate_alive_cells
    new_alive = {}
    self.height.times do |y|
      self.width.times do |x|
        alive = self.alive_cells.has_key?([y, x])

        alive_neighbors = [
          self.alive_cells.has_key?([y - 1, x - 1]), # Top Left
          self.alive_cells.has_key?([y - 1, x]), # Top
          self.alive_cells.has_key?([y - 1, x + 1]), # Top Right
          self.alive_cells.has_key?([y, x + 1]), # Right
          self.alive_cells.has_key?([y + 1, x + 1]), # Bottom Right
          self.alive_cells.has_key?([y + 1, x]), # Bottom
          self.alive_cells.has_key?([y + 1, x - 1]), # Bottom Left
          self.alive_cells.has_key?([y, x - 1]) # Left
        ].count(true)

        #Here it apply the Game of life rules for recalculate all the self.alive_cells
        if (alive and alive_neighbors.between?(2, 3)) or (!alive and alive_neighbors.eql? 3)
          new_alive[[y, x]] = true
        end
      end
    end

    self.alive_cells = new_alive
  end
end
