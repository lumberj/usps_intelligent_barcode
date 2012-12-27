module Imb

  # This class represents a mailer ID.

  class MailerId

    # The allowable range for a short (6-digit) mailer ID
    SHORT_RANGE = 0..899_999

    # The allowable range for a long (9-digit) mailer ID
    LONG_RANGE = 900_000_000..999_999_999

    # The list of all allowable ranges for a mailer ID
    RANGES = [SHORT_RANGE, LONG_RANGE]

    # Turn the argument into a MailerID if possible.  Accepts:
    # * MailerId
    # * String
    # * Integer

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

    # Create a new MailerId.
    # * +value+ - The integer value of the MailerId

    def initialize(value)
      @value = value
    end

    # Validate the value.  Raises ArgumentError if out of range.
    # * +long_mailer_id+ - truthy if the mailer ID is long (9 digits).

    def validate(long_mailer_id)
      unless in_range?
        raise ArgumentError, "Must be #{RANGES.join(' or ')}"
      end
    end

    # Return true if +o+ is equal.  +o+ may be any object which ::coerce
    # can turn into a MailerId.

    def ==(o)
      MailerId.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    # Return true if this is a long (9 digit) mailer ID

    def long?
      LONG_RANGE === @value
    end
    
    # Add this object's value to target, shifting it left as many
    # digts as are needed to make room.

    def shift_and_add_to(target, long_mailer_id)
      target * 10 ** num_digits + to_i
    end

    # Return the integer value of the mailer ID

    def to_i
      @value
    end

    private

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
