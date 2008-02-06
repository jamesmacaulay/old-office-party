require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tracks/index.html.erb" do
  include TracksHelper
  
  before(:each) do
    track_98 = mock_model(Track)
    track_98.should_receive(:persistent_id).and_return("MyString")
    track_98.should_receive(:name).and_return("MyString")
    track_98.should_receive(:artist).and_return("MyString")
    track_99 = mock_model(Track)
    track_99.should_receive(:persistent_id).and_return("MyString")
    track_99.should_receive(:name).and_return("MyString")
    track_99.should_receive(:artist).and_return("MyString")

    assigns[:tracks] = [track_98, track_99]
  end

  it "should render list of tracks" do
    render "/tracks/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

