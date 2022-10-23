$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'transmogrify'
require 'types'
require 'json'
require 'date'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, Minitest::Reporters::JUnitReporter.new] unless ENV['RM_INFO']

def parse_log_events(file_name)
    read_json(file_name).map { |r| LogEvent.new(r['server'], r['date'], r['severity'], r['process'], r['message']) }
end

def read_json(file_name)
    JSON.parse(File.read(File.join(File.dirname(__FILE__), file_name)))
end
