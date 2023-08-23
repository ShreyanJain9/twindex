def Relative(path)
  File.expand_path(path, File.dirname(caller_locations(1, 1).first.absolute_path))
end

module Twindex
  module Extensions
    refine Hash do
      def reject_empty
        reject(&(->(_, v) { v.nil? || v.empty? }))
      end
    end
    refine Class do
      def dynamic_attr_reader(attr_name, &block)
        define_method(attr_name) {
          instance_variable = "@#{attr_name}"
          if instance_variable_defined?(instance_variable)
            instance_variable_get(instance_variable)
          else
            instance_variable_set(instance_variable, instance_eval(&block))
          end
        }
      end
    end
    refine NilClass do
      def map(*)
        [self]
      end
    end
    refine Time do
      def empty?
        self == Time.at(0)
      end
    end
  end
end
