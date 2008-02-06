require File.dirname(__FILE__) + '/../../spec_helper'

describe "/opinions/index.html.erb" do
  include OpinionsHelper
  
  before(:each) do
    opinion_98 = mock_model(Opinion)
    opinion_98.should_receive(:user_id).and_return("1")
    opinion_98.should_receive(:track_id).and_return("1")
    opinion_98.should_receive(:rating).and_return("1")
    opinion_99 = mock_model(Opinion)
    opinion_99.should_receive(:user_id).and_return("1")
    opinion_99.should_receive(:track_id).and_return("1")
    opinion_99.should_receive(:rating).and_return("1")

    assigns[:opinions] = [opinion_98, opinion_99]
  end

  it "should render list of opinions" do
    render "/opinions/index.html.erb"
    response.should have_tag("tr>td", "1", 2)
  end
end

