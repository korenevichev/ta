class Line
  attr_reader :cells, :height

  def initialize(cells)
    @height = cells.count
    @cells = cells.map { |header, value| Cell.new(header, value) }
  end
end
