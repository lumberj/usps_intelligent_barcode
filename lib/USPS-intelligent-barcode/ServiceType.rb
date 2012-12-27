module Imb

  class ServiceType

    def self.coerce(o)
      case o
      when ServiceType
        o
      when String
        new(o.to_i)
      when Integer
        new(o)
      else
        raise ArgumentError, 'Cannot coerce to ServiceType'
      end
    end

    def initialize(value)
      @value = value
    end

    def validate(long_mailer_id)
      unless (RANGE) === @value
        raise ArgumentError, "Must be #{RANGE}"
      end
    end

    def ==(o)
      ServiceType.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    def shift_and_add_to(target, long_mailer_id)
      target * 10 ** NUM_DIGITS + to_i
    end

    protected

    def to_i
      @value
    end

    private

    RANGE = 0..999
    NUM_DIGITS = 3

  end

end
