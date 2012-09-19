require_relative 'lookup'

describe Tinyurl do
  before(:each) do
    Tinyurl.class_variable_set :@@lookup_tiny_urls, {}
    Tinyurl.stub(:environment => 'production')
  end

  it "works" do
    Tinyurl.get("http://kytrinyx.com").should eq("http://is.gd/5rzpAN")
  end

  it "caches" do
    Tinyurl.should_receive(:lookup).once.and_return {"http://short.url"}
    Tinyurl.get("http://google.com")
    Tinyurl.get("http://google.com")
  end

  it "just returns the original url on errors" do
    result = stub(:code => 409)
    Net::HTTP.stub(:start => result)
    Tinyurl.get("http://example.com").should eq('http://example.com')
  end

  specify "well, not all errors" do
    result = stub(:code => 500)
    Net::HTTP.stub(:start => result)
    # Not sure what actually causes the API to return 500
    ->{ Tinyurl.get("http://something.com") }.should raise_error Tinyurl::InvalidUrlException
  end

  it "doesn't worry about invalid urls" do
    Tinyurl.get("invalidurl").should eq("invalidurl")
  end

  it "swallows timeouts" do
    Net::HTTP.stub(:start).and_raise(Timeout::Error)
    Tinyurl.get("http://timeout.com").should eq("http://timeout.com")
  end

end
