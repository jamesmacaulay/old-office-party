require File.dirname(__FILE__) + '/../../spec_helper'

describe "/opinions/new.html.erb" do
  include OpinionsHelper
  
  before(:each) do
    @opinion = mock_model(Opinion)
    @opinion.stub!(:new_record?).and_return(true)
    @opinion.stub!(:user_id).and_return("1")
    @opinion.stub!(:track_id).and_return("1")
    @opinion.stub!(:rating).and_return("1")
    assigns[:opinion] = @opinion
  end

  it "should render new form" do
    render "/opinions/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", opinions_path) do
      with_tag("input#opinion_rating[name=?]", "opinion[rating]")
    end
  end
end


