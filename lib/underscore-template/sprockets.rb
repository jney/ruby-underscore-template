require 'sprockets'

module Underscore
  # Processing
  autoload :Template, "underscore-template/template"

  # JST engines
  ::Sprockets.register_engine '._', Template
end
