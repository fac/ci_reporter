require 'delegate'
require 'stringio'

require 'ci/reporter/duplex'

module CI
  module Reporter
    # Captures $stdout or $stderr in order report it in the XML file.
    class OutputCapture
      # Creates an OutputCapture and immediately starts capturing.
      def self.wrap(io, &assign)
        new(io, &assign).tap {|oc| oc.start}
      end

      def initialize(io, &assign)
        @original_io = io
        @captured_io = StringIO.new
        @assign_block = assign
      end

      # Start capturing IO.
      def start
        @assign_block.call(Duplex.new(@captured_io, @original_io))
      end

      # Finalize the capture and reset to the original IO object.
      def finish
        @assign_block.call(@original_io)
        @captured_io.string
      end
    end
  end
end
