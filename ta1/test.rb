
require 'csv'
require 'test/unit/assertions'
require_relative 'table_generator_from_csv'

class FormatterTest
    include Test::Unit::Assertions
    def test_int_formatter
      int_formatter = IntFormatter.new
      assert_equal(int_formatter.format('3'), ['3'])
    end

    def test_string_formatter
      string_formatter = StringFormatter.new
      assert_equal(string_formatter.format('text'), ['text'])
      assert_equal(string_formatter.format('aa bb cc'), ['aa', 'bb', 'cc'])
    end

    def test_money_formatter
      money_formatter = MoneyFormatter.new
      assert_equal(money_formatter.format('1000.33'), ['1 000.33'])
      assert_equal(money_formatter.format('0.001'), ['0.01'])
      assert_equal(money_formatter.format('10000.00'), ['10 000.00'])
    end 

    def test_formatter
      exception = assert_raise(RuntimeError) {Formatter.for('invalid')}
      assert_equal('Unsupported type!', exception.message )
    end 

    def test_cell
      cell = Cell.new(:int, '7')
      assert_equal(:right, cell.allignment)
      assert_equal(1, cell.width)
    end

    def test_line
      line = Line.new([[:int, '7'], [:string, 'string']])
      assert_equal(2, line.height)
    end

     def test_table1_rendering
      result = <<-TEXT

+--+----+---------+
| 1|aaa |1 000.33 |
|  |bbb |         |
|  |ccc |         |
+--+----+---------+
| 5|aaaa|0.01     |
|  |bbb |         |
+--+----+---------+
|13|aa  |10 000.00|
|  |bbbb|         |
+--+----+---------+
      TEXT
      table = Table.new("csv.csv")
      assert_equal(result, TableRenderer.render(table))
    end

    def test_table2_rendering
      result = <<-TEXT

+-----+----+--------+---+
|    1|aaa |1 000.33|  5|
|     |bbb |        |   |
|     |ccc |        |   |
+-----+----+--------+---+
|    5|aaaa|0.01    |100|
|     |bbb |        |   |
+-----+----+--------+---+
|13500|aa  |70.00   |  9|
+-----+----+--------+---+
      TEXT
      table = Table.new("test1.csv")
      assert_equal(result, TableRenderer.render(table))
    end

    def test_table3_rendering
      result = <<-TEXT

+-----+------+--+---+
|    1|aaa   |aa|  5|
|     |bbb   |bb|   |
|     |ccc   |cc|   |
|     |      |dd|   |
+-----+------+--+---+
|    5|aaaaaa|aa|100|
|     |bbb   |  |   |
+-----+------+--+---+
|13500|aa    |aa|  9|
+-----+------+--+---+
|   10|aa    |aa|  9|
|     |bb    |bb|   |
|     |cc    |  |   |
+-----+------+--+---+
      TEXT
      table = Table.new("test2.csv")
      assert_equal(result, TableRenderer.render(table))
    end

    def test
      test_int_formatter
      test_string_formatter
      test_money_formatter
      test_formatter
      test_cell
      test_line
      test_table1_rendering
      test_table2_rendering
      test_table3_rendering
    end
end

FormatterTest.new().test

