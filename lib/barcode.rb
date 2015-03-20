require 'chainable'

class Barcode

  include Chainable

  def initialize connection, link = nil
    @connection = connection
    next_in_chain(link)
  end

  def set_barcode_height(height)
    @connection.write_bytes(29, 104, height)
  end

  def print(text, type)
    set_type type
    print text
    end_print
  end

  private
  def set_type type
    @connection.write_bytes(29, 107, type)
  end

  def print text
    text.bytes { |b| @connection.write(b) }
  end

  def end_print
    @connection.write(0)
  end
end
