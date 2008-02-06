require File.dirname(__FILE__) + '/../spec_helper'

describe TracksController do
  describe "route generation" do

    it "should map { :controller => 'tracks', :action => 'index' } to /tracks" do
      route_for(:controller => "tracks", :action => "index").should == "/tracks"
    end
  
    it "should map { :controller => 'tracks', :action => 'new' } to /tracks/new" do
      route_for(:controller => "tracks", :action => "new").should == "/tracks/new"
    end
  
    it "should map { :controller => 'tracks', :action => 'show', :id => 1 } to /tracks/1" do
      route_for(:controller => "tracks", :action => "show", :id => 1).should == "/tracks/1"
    end
  
    it "should map { :controller => 'tracks', :action => 'edit', :id => 1 } to /tracks/1/edit" do
      route_for(:controller => "tracks", :action => "edit", :id => 1).should == "/tracks/1/edit"
    end
  
    it "should map { :controller => 'tracks', :action => 'update', :id => 1} to /tracks/1" do
      route_for(:controller => "tracks", :action => "update", :id => 1).should == "/tracks/1"
    end
  
    it "should map { :controller => 'tracks', :action => 'destroy', :id => 1} to /tracks/1" do
      route_for(:controller => "tracks", :action => "destroy", :id => 1).should == "/tracks/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'tracks', action => 'index' } from GET /tracks" do
      params_from(:get, "/tracks").should == {:controller => "tracks", :action => "index"}
    end
  
    it "should generate params { :controller => 'tracks', action => 'new' } from GET /tracks/new" do
      params_from(:get, "/tracks/new").should == {:controller => "tracks", :action => "new"}
    end
  
    it "should generate params { :controller => 'tracks', action => 'create' } from POST /tracks" do
      params_from(:post, "/tracks").should == {:controller => "tracks", :action => "create"}
    end
  
    it "should generate params { :controller => 'tracks', action => 'show', id => '1' } from GET /tracks/1" do
      params_from(:get, "/tracks/1").should == {:controller => "tracks", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'tracks', action => 'edit', id => '1' } from GET /tracks/1;edit" do
      params_from(:get, "/tracks/1/edit").should == {:controller => "tracks", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'tracks', action => 'update', id => '1' } from PUT /tracks/1" do
      params_from(:put, "/tracks/1").should == {:controller => "tracks", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'tracks', action => 'destroy', id => '1' } from DELETE /tracks/1" do
      params_from(:delete, "/tracks/1").should == {:controller => "tracks", :action => "destroy", :id => "1"}
    end
  end
end