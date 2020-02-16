require 'csv'
require_relative 'row'
require_relative 'line'
require_relative 'cell'
require_relative 'column'
require_relative 'formatter'

class Table
  attr_reader :rows, :columns

  def initialize(filepath)
    @rows = CSV.foreach(filepath, headers: true, col_sep: ';').map do |row|
      @columns ||= row.headers.map { Column.new }
      Row.new(row.map.each_with_index do |(header, value), index|
        value = Formatter.for(header).format(value)
        columns[index].save_width(value)

        value.map { |val| [header, val] }
      end)
    end
  end
end
