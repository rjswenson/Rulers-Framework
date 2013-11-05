require "rulers/version"
require "rulers/routing"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      elsif env['PATH_INFO'] == '/'
        return [404, {'Content-Type' => 'text/html'},
                ["A root page is not set yet"]]
      end

      begin
        klass, act = get_controller_and_action(env)
        controller = klass.new(env)
      rescue NoMethodError
        [501, {'Content-Type' => 'text/html'},
                ["Nice try, sukka! Route not implemented."]]
      else
        text = controller.send(act)
        [200, {'Content-Type' => 'text/html'},
            [text]]
      end
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end

