class Chef
  class Resource
    class RubyBlock < Chef::Resource
      if Chef::VERSION =~ /\A0\.6\./
        def initialize(name, collection = nil, data = nil)
          super(name, collection, data)
          init
        end
      else
        def initialize(name, run_context=nil)
          super(name, run_context)
          init
        end
      end

      def init
        @resource_name = :ruby_block
        @action        = :create
        @allowed_actions.push(:create)
      end

      def block(&block)
        if block
          @block = block
        else
          @block
        end
      end
    end
  end
end


class Chef
  class Provider
    class RubyBlock < Chef::Provider
      def load_current_resource
        true
      end

      def action_create
        @new_resource.block.call
      end
    end
  end
end

Chef::Platform.platforms[:default].merge! :ruby_block => Chef::Provider::RubyBlock
