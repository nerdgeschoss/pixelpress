module Pixelpress
  module InstanceInvocation
    def method_missing(m, *args, &block)
      return super unless respond_to_missing?(m)
      instance = new
      instance.instance_variable_set :@template_name, m.to_s
      instance.send(m, *args)
      instance.document
    end

    def respond_to_missing?(m, include_private = false)
      return true if new.methods.include?(m)
    end
  end
end
