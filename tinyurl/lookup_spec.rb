require_relative 'lookup'

describe Tinyurl do
  before(:each) do
    Tinyurl.class_variable_set :@@lookup_tiny_urls, {}
    Tinyurl.stub(:endpoint => "http://is.gd/create.php", :environment => 'production')
  end

  it "works" do
    Tinyurl.get("http://kytrinyx.com").should eq("http://is.gd/5rzpAN")
  end

  it "caches" do
    Tinyurl.should_receive(:lookup).once.and_return {"http://short.url"}
    Tinyurl.get("http://kytrinyx.com")
    Tinyurl.get("http://kytrinyx.com")
  end
end
