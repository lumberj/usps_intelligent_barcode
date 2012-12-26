module Imb

  class BarcodeId

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

    def initialize(value)
      @value = value
    end

    def validate(long_mailer_id)
      unless RANGE === @value
        raise ArgumentError, "Must be #{RANGE}"
      end
      unless LSB_RANGE === least_significant_digit
        raise ArgumentError, "Least significant digit must be #{LSB_RANGE}"
      end
    end

    def ==(o)
      BarcodeId.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    def most_significant_digit
      @value / 10
    end

    def least_significant_digit
      @value % 10
    end

    def shift_and_add_to(target, long_mailer_id)
      target *= 10
      target += most_significant_digit
      target *= 5
      target += least_significant_digit
      target
    end

    protected

    def to_i
      @value
    end

    private

    RANGE = 0..94
    LSB_RANGE = 0..4

  end

end
