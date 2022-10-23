class LogEvent

  attr_reader :server
  attr_reader :date
  attr_reader :severity
  attr_reader :process
  attr_reader :message

  # @param server [String]
  # @param date [String]
  # @param severity [String]
  # @param process [String]
  # @param message [String]
  def initialize(server, date, severity, process, message)
    raise "date must be an instance of String" unless date.kind_of?(String)

    @server = server
    @date = date
    @severity = severity
    @process = process
    @message = message
  end

  def ==(other)
    @server == other.server && @date == other.date && @severity == other.severity &&
      @process == other.process && @message == other.message
  end

  def to_s
    "[#{@severity}] #{@server} #{@process} #{@date} #{@message}"
  end

end
