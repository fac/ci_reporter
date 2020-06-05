module CI
  module Reporter
    class Duplex
      def initialize(primary, secondary)
        @primary = primary
        @secondary = secondary
      end

      def respond_to_missing?(name, include_all = true)
        super || @primary.respond_to?(name, include_all)
      end

      def method_missing(name, *args)
        @secondary.public_send(name, *args)
        @primary.public_send(name, *args)
      end
    end
  end
end
