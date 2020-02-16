require_relative 'table'
require_relative 'table_renderer'

class TableGeneratorFromCsv
  def self.generate(filepath)
    table = Table.new(filepath)
    print TableRenderer.render(table)
  end
end