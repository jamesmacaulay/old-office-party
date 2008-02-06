require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tracks/show.html.erb" do
  include TracksHelper
  
  before(:each) do
    @track = mock_model(Track)
    @track.stub!(:persistent_id).and_return("MyString")
    @track.stub!(:name).and_return("MyString")
    @track.stub!(:artist).and_return("MyString")

    assigns[:track] = @track
  end

  it "should render attributes in <p>" do
    render "/tracks/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

