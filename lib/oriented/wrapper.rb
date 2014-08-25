require 'active_support/concern'

module Oriented
  module Wrapper
    extend Oriented::Core::ToClass
    extend ActiveSupport::Concern

    attr_accessor :__java_obj

    def __java_obj
      @__java_obj 
    end

    def self.wrapper(java_obj)
      classname = java_obj.get_label
      return java_obj if classname.nil?      
      clname = Oriented::Registry.ruby_class_for(classname)
      return java_obj if clname[0].nil?
      clname = clname[0].upcase + clname[1..-1]
      klass = to_class(clname)
      return java_obj if java_obj.get_element_type == "Edge" && !(klass)
      new_instance = klass.orig_new

      new_instance.__java_obj = java_obj
      new_instance
      #puts java_obj.record.get_schema_class

    end

    # alias_method :wrap, :wrapper    

    Oriented::Core::JavaVertex.wrapper_proc=method(:wrapper)
    Oriented::Core::JavaEdge.wrapper_proc=method(:wrapper)


  end
end
