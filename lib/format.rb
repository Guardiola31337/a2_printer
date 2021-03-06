require 'chainable'

class Format

  include Chainable

  UNDERLINES = {
    none: 0,
    normal: 1,
    thick: 2
  }

  SIZES = {
    small: 0,
    medium: 10,
    large: 25
  }

  ALIGNMENT = {
    left: 0,
    center: 1,
    right: 2
  }

  def initialize connection, link = nil
    @connection = connection
    next_in_chain(link)
  end

  def set_size(size)
    @connection.write_bytes(29, 33, SIZES[size], 10)
  end

  def underline_on(weight)
    weight = sanitized_weight weight
    @connection.write_bytes(27, 45, weight)
  end

  def underline_off
    underline_on(UNDERLINES[:none])
  end

  def justify(position)
    @connection.write_bytes(0x1B, 0x61, ALIGNMENT[position])
  end

  def reset_format
    underline_off
    justify(:left)
  end

  private

  def sanitized_weight weight
    result = weight
    result = UNDERLINES[:none] if weight.nil?
    result = UNDERLINES[:thick] if weight > UNDERLINES[:thick]
    result
  end

end
