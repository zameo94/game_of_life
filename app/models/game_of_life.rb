class GameOfLife
  attr_accessor :width
  attr_accessor :height
  attr_accessor :file
  attr_accessor :generation
  attr_accessor :errors
  attr_accessor :alive_cells

  def initialize
    self.width = 0
    self.height = 0
    self.errors = ''
    self.alive_cells = {}
  end

  def run(path = "storage/sample.txt")
    self.alive_cells = {}
    self.errors = ''
    upload_txt(path)

    if self.errors.empty?
      print_frame
      sleep 0.3
      advance_frame
    else
      puts self.errors
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
      self.errors += "File not found. "
    end
  rescue
    self.errors += "Unable to upload file. "
  end

  # for a flexibility vision, I print the frame using alive_cells.
  # like that i can use print_frame() for the first and even all following generations
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

  #recursive function to keep the generations going
  def advance_frame
    recalculate_alive_cells
    self.generation += 1

    print_frame
    sleep 0.3
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
      self.errors += "Wrong file format. "
    end
  end

  def parse_file
    @rows = self.file.split(/\n/)
    get_generation
    get_width_height
    get_alive_cells if self.errors.empty?
  end

  def get_generation
    row = @rows[0]
    if row.include? "Generation "
      columns = row.split(":")
      self.generation = columns[0].last.to_i if columns[0].last.to_i > 0
      self.errors += "Unable to find generation. " if self.generation.nil?
    else
      self.errors += "Unable to find generation. "
    end
  end

  def get_width_height
    row = @rows[1]

      # if you convert a string into int, 0 was returned if the string haven't a numeric form
      if (row[0].to_i > 0) and (row[1].eql? " ") and (row[2].to_i > 0)
        self.width = row[2].to_i
        self.height = row[0].to_i
      else
        self.errors += "Unable to get width & height. "
      end
    rescue
      self.errors += "Width & height's row not present. "
  end

  def get_alive_cells
    self.height.times do |y|
      self.width.times do |x|
        # self.alice_cells contain the coordination of all live cells, used to advance the frame
        # sum [y + 2] for compensate the first & second file's lines
        if @rows[y + 2][x].eql? "*"
          self.alive_cells[[y, x]] = true
        end
      end
    end

    self.errors += "Unable to get alive_cells\n" if self.alive_cells.empty?
  end

  # recalculate_alive_cells is the program's engine.
  # Thanks to him, it's possible calculate the next generation
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

        #Here it apply the Conway's Game of life rules for recalculate all the alive_cells
        if (alive and alive_neighbors.between?(2, 3)) or (!alive and alive_neighbors.eql? 3)
          new_alive[[y, x]] = true
        end
      end
    end

    self.alive_cells = new_alive
  end
end
