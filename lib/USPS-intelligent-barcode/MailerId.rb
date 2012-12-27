module Imb

  class MailerId

    def self.coerce(o)
      case o
      when MailerId
        o
      when String
        new(o.to_i)
      when Integer
        new(o)
      else
        raise ArgumentError, 'Cannot coerce to MailerId'
      end
    end

    def initialize(value)
      @value = value
    end

    def validate(long_mailer_id)
      unless in_range?
        raise ArgumentError, "Must be #{RANGES.join(' or ')}"
      end
    end

    def ==(o)
      MailerId.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    def long?
      LONG_RANGE === @value
    end
    
    def shift_and_add_to(target, long_mailer_id)
      target * 10 ** num_digits + to_i
    end

    protected

    def to_i
      @value
    end

    private

    SHORT_RANGE = 0..899_999
    LONG_RANGE = 900_000_000..999_999_999
    RANGES = [SHORT_RANGE, LONG_RANGE]

    def in_range?
      RANGES.any? do |range|
        range === @value
      end
    end

    def num_digits
      if long?
        9
      else
        6
      end
    end

  end

end
