module Presenters
  class Base
    attr_accessor :object

    def initialize(object)
      @object = object
    end

    def render(object)
      raise "You must implement this in your class"
    end

    def show
      if @object.is_a?(Array)
        [].tap do |p|
          @object.each do |obj|
            p << render(obj)
          end
        end
      else
        render(@object)
      end
    end
  end
end
