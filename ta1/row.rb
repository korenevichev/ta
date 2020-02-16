class Row
  attr_reader :lines

  def initialize(row)
    max_row_height = row.map(&:size).max

    columns = row.map { |cells|
      next cells if cells.size == max_row_height
      cells.fill([:string, ''], (cells.size)..(max_row_height - 1))
    }

    @lines = columns.transpose.map { |cells| Line.new(cells) }
  end
end
