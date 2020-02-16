class Column
  attr_reader :width

  def initialize
    @width = 0
  end

  def save_width(value)
    new_width = value.map(&:size).max
    @width = new_width if new_width > @width
  end
end