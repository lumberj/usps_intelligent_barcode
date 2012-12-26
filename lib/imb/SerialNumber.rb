module Imb

  class SerialNumber

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

    def initialize(value)
      @value = value
    end

    def validate(long_mailer_id)
      range = 0..max_value(long_mailer_id)
      unless range === @value
        raise ArgumentError, "Must be #{range}"
      end
    end

    def ==(o)
      SerialNumber.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    def shift_and_add_to(target, long_mailer_id)
      target * 10 ** num_digits(long_mailer_id) + to_i
    end

    protected

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
