module Imb

  # This class represents the mail piece's serial number.

  class SerialNumber

    # Turn the argument into a SerialNumber if possible.  Accepts:
    # * SerialNumber
    # * String
    # * Integer

    def self.coerce(o)
      case o
      when SerialNumber
        o
      when String
        new(o.to_i)
      when Integer
        new(o)
      else
        raise ArgumentError, 'Cannot coerce to SerialNumber'
      end
    end

    # Create a new serial number from an integer.

    def initialize(value)
      @value = value
    end

    # Validate the value.  Raises ArgumentError if out of range.
    # * +long_mailer_id+ - truthy if the mailer ID is long (9 digits).

    def validate(long_mailer_id)
      range = 0..max_value(long_mailer_id)
      unless range === @value
        raise ArgumentError, "Must be #{range}"
      end
    end

    # Return true if +o+ is equal.  +o+ may be any object which ::coerce
    # can turn into a SerialNumber.

    def ==(o)
      SerialNumber.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    # Add this object's value to target, shifting it left as many
    # digts as are needed to make room.

    def shift_and_add_to(target, long_mailer_id)
      target * 10 ** num_digits(long_mailer_id) + to_i
    end

    # Return the integer value of the serial number

    def to_i
      @value
    end

    private

    def max_value(long_mailer_id)
      max_value = 10 ** num_digits(long_mailer_id) - 1
    end

    def num_digits(long_mailer_id)
      if long_mailer_id
        6
      else
        9
      end
    end

  end

end
