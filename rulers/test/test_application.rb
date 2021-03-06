require_relative "test_helper"

class TestController < Rulers::Controller
  def index
    "Hello, my name is Earl!" # Not rendering a view
  end
end

class TestApp < Rulers::Application
  def get_controller_and_action(env)
    [TestController, "index"]
  end
end

class RulersAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp.new
  end

def full_text_example
    get "/example/route"

    assert last_response.ok?
    body = last_response.body
    assert body["Hello, my name is Earl!"]
  end
end
