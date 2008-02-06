require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tracks/new.html.erb" do
  include TracksHelper
  
  before(:each) do
    @track = mock_model(Track)
    @track.stub!(:new_record?).and_return(true)
    @track.stub!(:persistent_id).and_return("MyString")
    @track.stub!(:name).and_return("MyString")
    @track.stub!(:artist).and_return("MyString")
    assigns[:track] = @track
  end

  it "should render new form" do
    render "/tracks/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", tracks_path) do
      with_tag("input#track_name[name=?]", "track[name]")
      with_tag("input#track_artist[name=?]", "track[artist]")
    end
  end
end


