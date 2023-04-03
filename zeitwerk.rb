require "set"

module Zeitwerk
  class Loader
    def initialize
      @dirs = Set.new
      @loaded = Set.new
      @autoloads = {}
      @constants = {}
      @inflector = Inflector.new
    end

    def push_dir(dir)
      @dirs << File.expand_path(dir)
    end

    def setup
      @autoloads.each do |path, (const, _)|
        load_file(path)
      end
    end

    def autoload(const_path, path)
      @autoloads[path] = [const_path, true]
    end

    def constantize(name)
      # Implementation omitted for brevity
    end

    def inflector
      @inflector
    end

    private

    def load_file(path)
      return if @loaded.include?(path)

      @loaded << path

      code = File.read(path)
      eval(code, TOPLEVEL_BINDING, path)
    end
  end

  class Inflector
    def inflect(patterns)
      @inflections.merge!(patterns)
    end

    def camelize(word)
      # Implementation omitted for brevity
    end
  end
end

loader = Zeitwerk::Loader.new
loader.push_dir(File.expand_path("lib", __dir__))
loader.inflector.inflect(
  "init.rb" => "Init",
  "rb" => "RB",
)
loader.setup

loader.eager_load # This will load all initialization files