require File.dirname(__FILE__) + '/../spec_helper'

describe Track do
  before(:each) do
    @track = Track.new
  end

  it "should be valid" do
    @track.should be_valid
  end
end

describe Track, ".load_from_itunes" do
  before(:each) do
    @track = Track.new
    
  end
  
  it "should populate persistent_id"
  
  it "should populate name"
  
  it "should populate artist"
  
  it "should populate album"
  
  it "should populate duration"
  
end
