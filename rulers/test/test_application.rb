require_relative "test_helper"

class TestApp < Rulers::Application
end

class RulersAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_request
    get "/"

    assert last_response.ok?
    body = last_response.body
    assert body["root"]
  end

  def full_text
    get "/"
    body = last_response.body
    assert body["A root page is not set yet"]
  end
end
