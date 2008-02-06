require File.dirname(__FILE__) + '/../spec_helper'

describe OpinionsController do
  describe "route generation" do

    it "should map { :controller => 'opinions', :action => 'index' } to /opinions" do
      route_for(:controller => "opinions", :action => "index").should == "/opinions"
    end
  
    it "should map { :controller => 'opinions', :action => 'new' } to /opinions/new" do
      route_for(:controller => "opinions", :action => "new").should == "/opinions/new"
    end
  
    it "should map { :controller => 'opinions', :action => 'show', :id => 1 } to /opinions/1" do
      route_for(:controller => "opinions", :action => "show", :id => 1).should == "/opinions/1"
    end
  
    it "should map { :controller => 'opinions', :action => 'edit', :id => 1 } to /opinions/1/edit" do
      route_for(:controller => "opinions", :action => "edit", :id => 1).should == "/opinions/1/edit"
    end
  
    it "should map { :controller => 'opinions', :action => 'update', :id => 1} to /opinions/1" do
      route_for(:controller => "opinions", :action => "update", :id => 1).should == "/opinions/1"
    end
  
    it "should map { :controller => 'opinions', :action => 'destroy', :id => 1} to /opinions/1" do
      route_for(:controller => "opinions", :action => "destroy", :id => 1).should == "/opinions/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'opinions', action => 'index' } from GET /opinions" do
      params_from(:get, "/opinions").should == {:controller => "opinions", :action => "index"}
    end
  
    it "should generate params { :controller => 'opinions', action => 'new' } from GET /opinions/new" do
      params_from(:get, "/opinions/new").should == {:controller => "opinions", :action => "new"}
    end
  
    it "should generate params { :controller => 'opinions', action => 'create' } from POST /opinions" do
      params_from(:post, "/opinions").should == {:controller => "opinions", :action => "create"}
    end
  
    it "should generate params { :controller => 'opinions', action => 'show', id => '1' } from GET /opinions/1" do
      params_from(:get, "/opinions/1").should == {:controller => "opinions", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'opinions', action => 'edit', id => '1' } from GET /opinions/1;edit" do
      params_from(:get, "/opinions/1/edit").should == {:controller => "opinions", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'opinions', action => 'update', id => '1' } from PUT /opinions/1" do
      params_from(:put, "/opinions/1").should == {:controller => "opinions", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'opinions', action => 'destroy', id => '1' } from DELETE /opinions/1" do
      params_from(:delete, "/opinions/1").should == {:controller => "opinions", :action => "destroy", :id => "1"}
    end
  end
end