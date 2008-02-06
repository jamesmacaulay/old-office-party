require File.dirname(__FILE__) + '/../../spec_helper'

describe "/opinions/show.html.erb" do
  include OpinionsHelper
  
  before(:each) do
    @opinion = mock_model(Opinion)
    @opinion.stub!(:user_id).and_return("1")
    @opinion.stub!(:track_id).and_return("1")
    @opinion.stub!(:rating).and_return("1")

    assigns[:opinion] = @opinion
  end

  it "should render attributes in <p>" do
    render "/opinions/show.html.erb"
    response.should have_text(/1/)
  end
end

