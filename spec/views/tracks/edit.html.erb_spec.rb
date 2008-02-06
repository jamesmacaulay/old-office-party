require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tracks/edit.html.erb" do
  include TracksHelper
  
  before do
    @track = mock_model(Track)
    @track.stub!(:persistent_id).and_return("MyString")
    @track.stub!(:name).and_return("MyString")
    @track.stub!(:artist).and_return("MyString")
    assigns[:track] = @track
  end

  it "should render edit form" do
    render "/tracks/edit.html.erb"
    
    response.should have_tag("form[action=#{track_path(@track)}][method=post]") do
      with_tag('input#track_name[name=?]', "track[name]")
      with_tag('input#track_artist[name=?]', "track[artist]")
    end
  end
end


