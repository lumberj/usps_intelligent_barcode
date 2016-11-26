module Imb

  # @!group Internal

  # Numeric conversions
  module NumericConversions

    # Convert a numeric to an array of at least +min_bytes+ bytes.  If
    # the resulting array is larger than is needed, then the most
    # significant bytes are zero padded.
    #
    # @param n [Numeric] The number to convert.
    # @param min_bytes [Integer] The minimum number of bytes to return
    # @return [Array<Integer>] Array of bytes between 0 and 255
    def numeric_to_bytes(n, min_bytes=0)
      n.to_s(16).rjust(2 * min_bytes, '0').scan(/../).map do |s|
        s.to_i(16)
      end
    end

  end

end
