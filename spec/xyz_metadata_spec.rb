require_relative '../xyz_metadata'

class Target
  BIRTHDAY = 'birthday'
  WEDDING = 'wedding'
  ANNIVERSARY = 'anniversary'
  FATHERSDAY = 'fathersday'
  MOTHERSDAY = 'mothersday'
  VALENTINES_DAY = 'valentines_day'
  CHRISTMAS = 'christmas'
end

describe XYZMetadata do

  let(:target) do
    messages = {
      :age => 42,
      :title => 'The Answer',
      :body => 'The universe and everything.'
    }
    stub(:target, messages)
  end

  specify "birthday" do
    target.stub(:kind => Target::BIRTHDAY)
    XYZMetadata.iptc_caption_from(target).should eq("42 years\nThe Answer\nThe universe and everything.")
  end

  specify "wedding" do
    target.stub(:kind => Target::WEDDING)
    XYZMetadata.iptc_caption_from(target).should eq("The universe and everything.\nThe Answer")
  end

  specify "anniversary" do
    target.stub(:kind => Target::ANNIVERSARY)
    XYZMetadata.iptc_caption_from(target).should eq("The universe and everything.\nThe Answer")
  end

  specify "fathersday" do
    target.stub(:kind => Target::FATHERSDAY)
    XYZMetadata.iptc_caption_from(target).should eq("The Answer\nThe universe and everything.")
  end

  specify "mothersday" do
    target.stub(:kind => Target::MOTHERSDAY)
    XYZMetadata.iptc_caption_from(target).should eq("The Answer\nThe universe and everything.")
  end

  specify "valentinesday" do
    target.stub(:kind => Target::VALENTINES_DAY)
    XYZMetadata.iptc_caption_from(target).should eq("The Answer\nThe universe and everything.")
  end

  specify "christmas" do
    target.stub(:kind => Target::CHRISTMAS)
    XYZMetadata.iptc_caption_from(target).should eq("The Answer\nThe Answer\nThe universe and everything.")
  end

  specify "unknown" do
    target.stub(:kind => "none_such")
    XYZMetadata.stub(:logger => stub(:error => nil))
    XYZMetadata.iptc_caption_from(target).should eq("The Answer\nThe universe and everything.")
  end

end

