module Oriented
  module Core
    module ToClass
      def to_class(class_name, parent = Kernel)
          chain = class_name.split "::"
          klass = parent.const_get chain.shift
          return chain.size < 1 ? (klass.is_a?(Class) ? klass : nil) : to_class(chain.join("::"), klass)
          rescue
            nil
      end
    end
  end
end