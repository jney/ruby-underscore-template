# UnderscoreTemplate (Embedded JavaScript) template compiler for Ruby
# This is a port of Underscore.js' `_.template` function:
# http://documentcloud.github.com/underscore/

module Underscore::Engine
  JS_UNESCAPES = {
    '\\' => '\\',
    "'" => "'",
    "\"" => "\"",
    'r' => "\r",
    'n' => "\n",
    't' => "\t",
    'u2028' => "\u2028",
    'u2029' => "\u2029"
  }
  JS_ESCAPES = JS_UNESCAPES.invert
  JS_UNESCAPE_PATTERN = /\\(#{Regexp.union(JS_UNESCAPES.keys)})/
  JS_ESCAPE_PATTERN = Regexp.union(JS_ESCAPES.keys)
  EVALUATION_PATTERN = /<%([\s\S]+?)%>/
  INTERPOLATION_PATTERN = /<%=([\s\S]+?)%>/
  ESCAPE_PATTERN = /<%-([\s\S]+?)%>/

  class << self
    attr_accessor :underscore_available

    # Compiles an UnderscoreTemplate template to a JavaScript function. The compiled
    # function takes an optional argument, an object specifying local
    # variables in the template.
    #
    #     UnderscoreTemplate.compile("Hello <%= name %>")
    #     # => "_.template('Hello <%= name %>')"
    #
    def compile(source, options = {})
      source = source.dup
      js_escape!(source)
      "_.template(\"#{source}\")"
    end

    # Evaluates an UnderscoreTemplate template with the given local variables and
    # compiler options. You will need the ExecJS
    # (https://github.com/sstephenson/execjs/) library and a
    # JavaScript runtime available.
    #
    #     UnderscoreTemplate.evaluate("Hello <%= name %>", :name => "world")
    #     # => "Hello world"
    #
    def evaluate(template, locals = {}, options = {})
      underscore_context.call(compile(template, options), locals)
    end

    protected
      def js_escape!(source)
        source.gsub!(JS_ESCAPE_PATTERN) { |match| '\\' + JS_ESCAPES[match] }
        source
      end

      def js_unescape!(source)
        source.gsub!(JS_UNESCAPE_PATTERN) { |match| JS_UNESCAPES[match[1..-1]] }
        source
      end

      def underscore_context
        @@underscore_context ||= begin
          require 'execjs'
          ExecJS.compile(File.read(File.join(File.dirname(__FILE__), '..', '..', 'ext', 'underscore.js')))
        end
      end
  end

end
