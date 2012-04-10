require 'test/unit'
require 'fcc-content-api'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  #c.stub_with :webmock
end