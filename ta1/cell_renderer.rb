require_relative 'row'
require_relative 'line'
require_relative 'cell'

class CellRenderer
  SPACE = ' '.freeze

  def self.render(cell, width)
    padding = SPACE * (width - cell.width)

    if cell.allignment == :left
      cell.value + padding
    else
      padding + cell.value
    end
  end
end
