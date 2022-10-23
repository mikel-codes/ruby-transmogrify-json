require 'date'
require 'types'

class Transmogrifier

  # For the raw events given (an Array of Hashes) returns an Array of LogEvent instances (see `types.rb` and unit tests
  # for examples).
  #
  # to setup to run tests, use `bundle install` first, and then run tests using `bundle exec rake ci`
  #
  def transmogrify(raw_events)
    types = {}
    ans = []
    raw_events.each do |rw|
      if rw.has_key?("events")
        rw['events'].each do |e|
          types['server'] = rw['server']
          if rw['date'].is_a?  Integer
            types['date'] = Time.at(rw['date'] / 1000).utc.strftime('%FT%T.%3NZ')
          else
            types['date'] = rw['date']
          end
          types['severity'] = e['indicator-type'] == 'message' ? "INFO" : "WARN"
          types['message']  = e['indicator-type'] == 'message' ? e['indicator-value'] : e['indicator-type'].concat(" #{e['indicator-value']}")
          types['process'] = rw["source"]
          obj = LogEvent.new(types['server'], types['date'], types['severity'],types['process'], types['message'])
          ans << obj
        end
      else
        types['process'] = rw['process']
        types['message'] = rw['message']
        types['severity'] = rw['severity']
        if rw['date'].is_a?  Integer
          types['date'] = Time.at(rw['date']).utc.strftime('%FT%T.%3NZ')
        else
          types['date'] = rw['date']
        end
        types['server'] = rw['server']
        obj = LogEvent.new(types['server'], types['date'], types['severity'],types['process'], types['message'])
        ans << obj
      end
    end

    return ans
  end
end


#PLEASE I FACED ISSUES WITH TIME CONVERSION, SURE THAT MAY BE THE LIKELY BUG HERE
