require 'action_controller'
require_relative 'renderers/weasyprint_renderer'
require_relative 'renderers/test_renderer'
require_relative 'instance_invocation'
require_relative 'rendering'

module Pixelpress
  class Base < ActionController::Base
    extend InstanceInvocation
    include Rendering
  end
end
