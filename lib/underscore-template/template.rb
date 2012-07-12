require 'sprockets'
require 'tilt'

module Underscore
  # Tilt engine class for the Underscore compiler.
  class Template < Tilt::Template
    # Check to see if Underscore is loaded
    def self.engine_initialized?
      defined? ::Underscore::Engine
    end

    # Autoload underscore-template library. If the library isn't loaded, Tilt will produce
    # a thread safetly warning. If you intend to use `._` files, you
    # should explicitly require it.
    def initialize_engine
      require_template_library 'underscore-template'
    end

    def prepare
    end

    # Compile template data with Underscore compiler.
    #
    # Returns a JS function definition String. The result should be
    # assigned to a JS variable.
    #
    #     # => "_.template(...)"
    #
    def evaluate(scope, locals, &block)
      Underscore::Engine.compile(data)
    end
  end
end
