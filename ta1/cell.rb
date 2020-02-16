class Cell
  attr_reader :width, :value, :allignment

  def initialize(header, value)
    @header = header
    @value = value
    @width = @value.size
    @allignment = Formatter.for(@header).allignment
  end
end
