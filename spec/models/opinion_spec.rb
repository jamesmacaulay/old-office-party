require File.dirname(__FILE__) + '/../spec_helper'

describe Opinion do
  before(:each) do
    @opinion = Opinion.new
  end

  it "should be valid" do
    @opinion.should be_valid
  end
end
