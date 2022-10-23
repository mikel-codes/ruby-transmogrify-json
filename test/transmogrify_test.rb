require 'test_helper'
require 'debug'
class TransmogrifyTest < Minitest::Test

  # add additional test cases here of other patterns that concern you,
  # all test cases you add must pass

  def test_transmogrify_with_iso_date
    raw_events =   [{
        'server'   => '10.10.0.177',
        'date'     => '2019-07-01T15:27:25.000Z',
        'severity' => 'WARN',
        'process'  => 'microsrvc',
        'message'  => 'retry failed to downstream service luxadapter'
    }]

    # make sure that our desired datetime format is maintained
    test_iso_date = DateTime.parse('2019-07-01T15:27:25.000Z').strftime('%FT%T.%3NZ')

    expected_log_events = [LogEvent.new('10.10.0.177', test_iso_date, 'WARN', 'microsrvc', 'retry failed to downstream service luxadapter')]
    actual_log_events = @transmogrifier.transmogrify(raw_events)

    assert_equal expected_log_events, actual_log_events
  end

  def test_transmogrify_all_formats
    raw_events = read_json('transmogrify-input.json')
    expected_log_events = parse_log_events('transmogrify-output.json')
    actual_log_events = @transmogrifier.transmogrify(raw_events)
    
    assert_equal expected_log_events, actual_log_events
  end

  def setup
    @transmogrifier = Transmogrifier.new
  end

end
