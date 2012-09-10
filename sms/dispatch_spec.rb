require_relative 'dispatch'

class HTTPClient
end

describe SMS::Dispatch do

  let(:alice) { SMS::Recipient.new('12345678') }
  let(:fake_http_client) { stub(:fake_http_client) }

  it "sends it" do
    HTTPClient.stub(:new => fake_http_client)

    url = "https://sms.example.com/sms/dispatch"
    options = {"USER"=>"ppalace","PW"=>"secret", "RCV"=>"4712345678", "SND"=>"Pigeon Palace", "TXT"=>"Just checking."}
    success_response = "0\r\nOK\r\n"

    fake_http_client.should_receive(:post_content).with(url, options).and_return { success_response }

    sms = SMS::Dispatch.new(alice, "Just checking.")
    sms.dispatch!

    # Retrofitted tests.
    # Think about why this has to be here to make the test pass/fail correctly.
    sms.logger.messages.should eq([])
  end

  it "fails at the sms provider" do
    HTTPClient.stub(:new => fake_http_client)

    fake_http_client.should_receive(:post_content).and_return { "1\r\nBAD\r\n" }

    sms = SMS::Dispatch.new(alice, "Call me :(")
    sms.dispatch!

    sms.logger.messages.first.should match(/Denied by service provider/)
  end

  it "doesn't resend dispatched messages" do
    sms = SMS::Dispatch.new(alice, "Try, try, again.")
    sms.dispatched_at = 1

    HTTPClient.should_not_receive(:new)
    sms.dispatch!

    sms.logger.messages.should eq([])
  end

  it "can't send without a number" do
    sms = SMS::Dispatch.new(SMS::Recipient.new, "Whatevs.")
    sms.dispatch!
    sms.logger.messages.first.should match(/Missing mobile number/)
  end

end
