require 'json'
#require 'pry'
require 'test/unit'

require 'ssl_labs'

class TestEndpointData < Test::Unit::TestCase

  def test_constructor
    json = File.read(File.join(File.dirname(__FILE__), 'endpoint_data.json'))
    epd = SslLabs::EndpointData.from_json(json)
    # XXX insert tests here
    #binding.pry
  end

end
