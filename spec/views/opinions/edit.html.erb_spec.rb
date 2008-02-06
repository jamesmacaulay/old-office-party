require File.dirname(__FILE__) + '/../../spec_helper'

describe "/opinions/edit.html.erb" do
  include OpinionsHelper
  
  before do
    @opinion = mock_model(Opinion)
    @opinion.stub!(:user_id).and_return("1")
    @opinion.stub!(:track_id).and_return("1")
    @opinion.stub!(:rating).and_return("1")
    assigns[:opinion] = @opinion
  end

  it "should render edit form" do
    render "/opinions/edit.html.erb"
    
    response.should have_tag("form[action=#{opinion_path(@opinion)}][method=post]") do
      with_tag('input#opinion_rating[name=?]', "opinion[rating]")
    end
  end
end


