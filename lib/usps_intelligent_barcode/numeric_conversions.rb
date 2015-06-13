module Imb

  # @!group Internal

  # Numeric conversions

  module NumericConversions

    # Convert a numeric to an array of at least +min_bytes+ bytes.
    # @param [Numeric] n
    # @param [Integer] min_bytes
    # @return [[Integer]] Array of bytes

    def numeric_to_bytes(n, min_bytes=0)
      n.to_s(16).rjust(2 * min_bytes, '0').scan(/../).map do |s|
        s.to_i(16)
      end
    end

  end

end
