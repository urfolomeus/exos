require_relative './sms/recipient'
require_relative './sms/logger'
class SMS

  ORVEMCOM_USER = 'ppalace'
  ORVEMCOM_PASSWORD = 'secret'
  OREVEMCOM_SERVICE_URL = "https://sms.example.com/sms/dispatch"
  SENDER = "Pigeon Palace"

  attr_reader :recipient, :message
  attr_accessor :failed_at, :dispatched_at

  def initialize(recipient, message)
    @recipient = recipient
    @message = message
  end

  def dispatch!
    return unless self.dispatched_at.nil?
    unless self.recipient.number.nil?
      begin
        result = HTTPClient.new.post_content(OREVEMCOM_SERVICE_URL,
          {"USER"=>ORVEMCOM_USER,"PW"=>ORVEMCOM_PASSWORD,
           "RCV"=>self.recipient.msisdn,
           "SND"=>SENDER,
           "TXT"=>self.message})
        if result =~ /^0/
          self.dispatched_at = Time.now
        else
          logger.error(
            "Dispatching message #{self.id} to #{self.recipient}. Denied by service provider (#{result})")
          self.failed_at = Time.now
        end
      rescue Exception => e
        logger.error(
          "Dispatching message #{self.id} to #{self.recipient} (#{e.inspect})")
        self.failed_at = Time.now
      end
    else
      logger.error(
        "Could not send message #{self.id} to #{self.recipient}. Missing mobile number.")
      self.failed_at = Time.now
    end
    self.save!
  end

  def logger
    @logger ||= SMS::Logger.new
  end

  def save!
  end

  def to_s
    "<SMS #{id}: #{message}>"
  end

  def id
    1337
  end

end

