require "erubis"
require "rulers/file_model"
require "rack/request"

module Rulers
  class Controller
    include Rulers::Model
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def response(text, status = 200, headers = {})
      raise "Already responded" if @response
      a = [text].flatten
      @response = Rack::Response.new(a, status, headers)
    end

    def get_response
      @response
    end

    def render_response(*args)
      response(render(*args))
    end

    def params
      request.params
    end

    def render(view_name, locals = {})
      filename = File.join "app", "views",
                  controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)

      # pulls variables out of controller and into views.
      instance_variables.each do |var|
        eruby.instance_variable_set(var, instance_variable_get(var))
      end

      eruby.result locals.merge(:env => env)
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub /Controller$/, ""
      Rulers.to_underscore klass
    end
  end
end
