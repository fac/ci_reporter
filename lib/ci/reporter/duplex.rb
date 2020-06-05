module CI
  module Reporter
    class Duplex
      def initialize(captured, original)
        @captured = captured
        @original = original
      end

      def respond_to_missing?(name, include_all = true)
        super || @original.respond_to?(name, include_all)
      end

      def method_missing(name, *args)
        if @captured.respond_to?(name)
          @captured.public_send(name, *args)
        end
        @original.public_send(name, *args)
      end
    end
  end
end
