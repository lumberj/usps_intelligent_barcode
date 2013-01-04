module Imb

  # Represents a routing code

  class RoutingCode

    # Turn the argument into a RoutingCode if possible.  Accepts:
    # * {RoutingCode}
    # * nil (no routing code)
    # * String of length:
    #   * 0 - no routing code
    #   * 5 - zip
    #   * 9 - zip + plus4
    #   * 11 - zip + plus4 + delivery point
    # * Array of [zip, plus4, delivery point]
    # @return [RoutingCode]

    def self.coerce(o)
      case o
      when nil
        coerce('')
      when RoutingCode
        o
      when Array
        RoutingCode.new(*o)
      when String
        RoutingCode.new(*string_to_array(o))
      else
        raise ArgumentError, 'Cannot coerce to RoutingCode'
      end
    end

    # @return [Integer] The ZIP (or nil)
    attr_accessor :zip

    # @return [Integer] The plus4 (or nil)
    attr_accessor :plus4

    # @return [Integer] The delivery point (or nil)
    attr_accessor :delivery_point
    
    # Create a RoutingCode.  Arguments are:
    # * +zip+ - Integer zip (or nil)
    # * +plus4+ - Integer plus4 (or nil)
    # * +delivery_point+ - Integer delivery poitn (or nil)

    def initialize(zip, plus4, delivery_point)
      @zip = arg_to_i(zip)
      @plus4 = arg_to_i(plus4)
      @delivery_point = arg_to_i(delivery_point)
    end

    # Return true if this object is equal to o
    # @param [Object] o Any object acceptable to {.coerce}

    def ==(o)
      RoutingCode.coerce(o).to_a == to_a
    rescue ArgumentError
      false
    end

    # @!group Internal

    # Convert a string representation of a routing code into
    # an array that can be passed to the constructor.
    # +s+ is a string of length:
    # * 0 - no routing code
    # * 5 - zip
    # * 9 - zip + plus4
    # * 11 - zip + plus4 + delivery point
    # The result is an array of [zip, zip4, delivery point]

    def self.string_to_array(s)
      s = s.gsub(/[\D]/, '')
      match = /^(?:(\d{5})(?:(\d{4})(\d{2})?)?)?$/.match(s)
      unless match
        raise ArgumentError, "Bad routing code: #{s.inspect}"
      end
      zip, plus4, delivery_point = match.to_a[1..-1]
      [zip, plus4, delivery_point]
    end

    # Validate the value.
    # @param long_mailer_id truthy if the mailer ID is long (9 digits).
    # @raise ArgumentError if invalid

    def validate(long_mailer_id)
    end

    # Add this object's value to target, shifting it left as many
    # digts as are needed to make room.
    # @param [Integer] target The target to be shifted and added to
    # @param long_mailer_id truthy if the mailer ID is long (9 digits).
    # @return [Integer] The new value of the target

    def shift_and_add_to(target, long_mailer_id)
      target * 10 ** NUM_DIGITS + convert
    end

    # @!endgroup

    protected

    # Convert to an array of [zip, plus4, delivery point]

    def to_a
      [@zip, @plus4, @delivery_point]
    end

    private

    NUM_DIGITS = 11 #:nodoc:

    def arg_to_i(o)
      o.andand.to_i
    end
    
    # Convert to an integer value

    def convert
      if @zip && @plus4 && @delivery_point
        @zip * 1000000 + @plus4 * 100 + @delivery_point + 1000100001
      elsif @zip && @plus4
        @zip * 10000 + @plus4 + 100001
      elsif @zip
        @zip + 1
      else
        0
      end
    end

  end

end
