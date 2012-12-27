module Imb

  class RoutingCode

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

    def self.string_to_array(s)
      s = s.gsub(/[\D]/, '')
      match = /^(?:(\d{5})(?:(\d{4})(\d{2})?)?)?$/.match(s)
      unless match
        raise ArgumentError, "Bad routing code: #{s.inspect}"
      end
      zip, plus4, delivery_point = match.to_a[1..-1]
      [zip, plus4, delivery_point]
    end

    attr_accessor :zip, :plus4, :delivery_point
    
    def initialize(zip, plus4, delivery_point)
      @zip = arg_to_i(zip)
      @plus4 = arg_to_i(plus4)
      @delivery_point = arg_to_i(delivery_point)
    end

    def validate(long_mailer_id)
    end
    
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

    def to_a
      [@zip, @plus4, @delivery_point]
    end

    def ==(o)
      RoutingCode.coerce(o).to_a == to_a
    rescue ArgumentError
      false
    end

    def shift_and_add_to(target, long_mailer_id)
      target * 10 ** NUM_DIGITS + convert
    end

    private

    NUM_DIGITS = 11

    def arg_to_i(o)
      o.andand.to_i
    end

  end

end
