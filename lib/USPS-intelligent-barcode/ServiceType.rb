module Imb

  class ServiceType

    # The valid range of a service type
    RANGE = 0..999

    # Turn the argument into a ServiceType if possible.  Accepts:
    # * ServiceType
    # * String
    # * Integer

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

    # Create a service type from an integer

    def initialize(value)
      @value = value
    end

    # Validate the value.  Raises ArgumentError if out of range.
    # * +long_mailer_id+ - truthy if the mailer ID is long (9 digits).

    def validate(long_mailer_id)
      unless (RANGE) === @value
        raise ArgumentError, "Must be #{RANGE}"
      end
    end

    # Return true if +o+ is equal.  +o+ may be any object which ::coerce
    # can turn into a ServiceType.

    def ==(o)
      ServiceType.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    # Add this object's value to target, shifting it left as many
    # digts as are needed to make room.

    def shift_and_add_to(target, long_mailer_id)
      target * 10 ** NUM_DIGITS + to_i
    end

    # Return the integer value of the service type

    def to_i
      @value
    end

    private

    NUM_DIGITS = 3 #:nodoc:

  end

end
