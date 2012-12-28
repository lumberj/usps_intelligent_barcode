module Imb

  # Numeric conversions This class is internal and may change.

  module NumericConversions

    # Convert a numberic to an array of at least +min_bytes+ bytes.

    def numeric_to_bytes(n, min_bytes=0)
      n.to_s(16).rjust(2 * min_bytes, '0').scan(/../).map do |s|
        s.to_i(16)
      end
    end

  end

end
