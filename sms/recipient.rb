class Recipient

  attr_reader :number
  def initialize(number = nil)
    @number = number
  end

  # Normalize into an MSISDN.
  def self.msisdnize(number)
    number = "47#{number}" unless number =~ /^\+/
    number.gsub!(/^\+/, '')
    number
  end

  def msisdn
    Recipient.msisdnize(number)
  end

  def to_s
    "<Recipient:##{number.inspect}>"
  end

end

