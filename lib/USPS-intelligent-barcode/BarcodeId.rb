module Imb

  # This class represents a Barcode ID

  class BarcodeId

    # The allowable range of a barcode ID
    RANGE = 0..94

    # The allowable range of a barcode ID's least significant digit
    LSD_RANGE = 0..4

    # Turn the argument into a BarcodeID if possible.  Accepts:
    # * BarcodeId
    # * String
    # * Integer

    def self.coerce(o)
      case o
      when BarcodeId
        o
      when String
        new(o.to_i)
      when Integer
        new(o)
      else
        raise ArgumentError, 'Cannot coerce to BarcodeId'
      end
    end

    # Create a new BarcodeId
    # * +value+ - The integer value of the barcode ID

    def initialize(value)
      @value = value
    end

    # Validate the value.  Raises ArgumentError if out of range.
    # * +long_mailer_id+ - truthy if the mailer ID is long (9 digits).

    def validate(long_mailer_id)
      unless RANGE === @value
        raise ArgumentError, "Must be #{RANGE}"
      end
      unless LSD_RANGE === least_significant_digit
        raise ArgumentError, "Least significant digit must be #{LSD_RANGE}"
      end
    end

    # Return true if +o+ is equal.  +o+ may be any object which ::coerce
    # can turn into a BarcodeId.

    def ==(o)
      BarcodeId.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    # Add this object's value to target, shifting it left as many
    # digts as are needed to make room.

    def shift_and_add_to(target, long_mailer_id)
      target *= 10
      target += most_significant_digit
      target *= 5
      target += least_significant_digit
      target
    end

    # Return the integer value of the barcode ID

    def to_i
      @value
    end

    private

    def most_significant_digit
      @value / 10
    end

    def least_significant_digit
      @value % 10
    end

  end

end
