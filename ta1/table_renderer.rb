# frozen_string_literal: true

require_relative 'table'
require_relative 'cell_renderer'

class TableRenderer
  VERTICAL_BORDER_CHAR = '|'
  HORIZONTAL_BORDER_CHAR = '-'
  CORNER_BORDER_CHAR = '+'
  NEWLINE = "\n"

  attr_reader :table, :horizontal_border

  def self.render(table)
    new(table).render
  end

  def initialize(table)
    @table = table
    @horizontal_border = prepare_horizontal_border(table)
  end

  def render
    join_rows(table.rows.map do |row|
      join_lines(row.lines.map do |line|
        join_cells(line.cells.each_with_index.map do |cell, index|
          CellRenderer.render(cell, table.columns[index].width)
        end)
      end)
    end)
  end

  def join_rows(rows)
    horizontal_border +
      rows.join(horizontal_border) +
      horizontal_border
  end

  def join_lines(lines)
    lines.join(NEWLINE)
  end

  def join_cells(cells)
    VERTICAL_BORDER_CHAR +
      cells.join(VERTICAL_BORDER_CHAR) +
      VERTICAL_BORDER_CHAR
  end

  def prepare_horizontal_border(table)
    lines = NEWLINE + CORNER_BORDER_CHAR

    table.columns.map(&:width).each do |width|
      lines << HORIZONTAL_BORDER_CHAR * width
      lines << CORNER_BORDER_CHAR
    end

    lines << NEWLINE
  end
end