class Formatter
  def self.for(type)
    case type.to_s
    when 'int'
      IntFormatter.new
    when 'string'
      StringFormatter.new
    when 'money'
      MoneyFormatter.new  
    else
      raise 'Unsupported type!'
    end
  end
end

class IntFormatter
  def format(data)
    [data]
  end 

  def allignment
    :right  
  end      
end

class StringFormatter
  def format(data)
    data.split(' ')
  end

  def allignment
    :left  
  end
end

class MoneyFormatter
  def format(data)
    [divide_by_rank(with_precision(data))]
  end

  def with_precision(number, precision = 2)
    "%.#{precision}f" % number.to_f.ceil(precision)
  end

  def divide_by_rank(number)
    number.reverse.gsub(/(\d{3})(?=\d)/, '\1 ').reverse
  end

  def allignment
    :left  
  end
end