require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"

module Rulers
  class Application
    def redirect_to(location)
      [302, ["Location" => location], []]
    end

    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      elsif env['PATH_INFO'] == '/'
        return redirect_to("/home/index")
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
      rescue
        [501, {'Content-Type' => 'text/html'},
              ["Nice try, sukka! Route not implemented."]]
      end

      [200, {'Content-Type' => 'text/html'},
          [text]]
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

