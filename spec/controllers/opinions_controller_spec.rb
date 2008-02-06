require File.dirname(__FILE__) + '/../spec_helper'

describe OpinionsController do
  describe "handling GET /opinions" do

    before(:each) do
      @opinion = mock_model(Opinion)
      Opinion.stub!(:find).and_return([@opinion])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all opinions" do
      Opinion.should_receive(:find).with(:all).and_return([@opinion])
      do_get
    end
  
    it "should assign the found opinions for the view" do
      do_get
      assigns[:opinions].should == [@opinion]
    end
  end

  describe "handling GET /opinions.xml" do

    before(:each) do
      @opinion = mock_model(Opinion, :to_xml => "XML")
      Opinion.stub!(:find).and_return(@opinion)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all opinions" do
      Opinion.should_receive(:find).with(:all).and_return([@opinion])
      do_get
    end
  
    it "should render the found opinions as xml" do
      @opinion.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /opinions/1" do

    before(:each) do
      @opinion = mock_model(Opinion)
      Opinion.stub!(:find).and_return(@opinion)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the opinion requested" do
      Opinion.should_receive(:find).with("1").and_return(@opinion)
      do_get
    end
  
    it "should assign the found opinion for the view" do
      do_get
      assigns[:opinion].should equal(@opinion)
    end
  end

  describe "handling GET /opinions/1.xml" do

    before(:each) do
      @opinion = mock_model(Opinion, :to_xml => "XML")
      Opinion.stub!(:find).and_return(@opinion)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the opinion requested" do
      Opinion.should_receive(:find).with("1").and_return(@opinion)
      do_get
    end
  
    it "should render the found opinion as xml" do
      @opinion.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /opinions/new" do

    before(:each) do
      @opinion = mock_model(Opinion)
      Opinion.stub!(:new).and_return(@opinion)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new opinion" do
      Opinion.should_receive(:new).and_return(@opinion)
      do_get
    end
  
    it "should not save the new opinion" do
      @opinion.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new opinion for the view" do
      do_get
      assigns[:opinion].should equal(@opinion)
    end
  end

  describe "handling GET /opinions/1/edit" do

    before(:each) do
      @opinion = mock_model(Opinion)
      Opinion.stub!(:find).and_return(@opinion)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the opinion requested" do
      Opinion.should_receive(:find).and_return(@opinion)
      do_get
    end
  
    it "should assign the found Opinion for the view" do
      do_get
      assigns[:opinion].should equal(@opinion)
    end
  end

  describe "handling POST /opinions" do

    before(:each) do
      @opinion = mock_model(Opinion, :to_param => "1")
      Opinion.stub!(:new).and_return(@opinion)
    end
    
    describe "with successful save" do
  
      def do_post
        @opinion.should_receive(:save).and_return(true)
        post :create, :opinion => {}
      end
  
      it "should create a new opinion" do
        Opinion.should_receive(:new).with({}).and_return(@opinion)
        do_post
      end

      it "should redirect to the new opinion" do
        do_post
        response.should redirect_to(opinion_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @opinion.should_receive(:save).and_return(false)
        post :create, :opinion => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /opinions/1" do

    before(:each) do
      @opinion = mock_model(Opinion, :to_param => "1")
      Opinion.stub!(:find).and_return(@opinion)
    end
    
    describe "with successful update" do

      def do_put
        @opinion.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the opinion requested" do
        Opinion.should_receive(:find).with("1").and_return(@opinion)
        do_put
      end

      it "should update the found opinion" do
        do_put
        assigns(:opinion).should equal(@opinion)
      end

      it "should assign the found opinion for the view" do
        do_put
        assigns(:opinion).should equal(@opinion)
      end

      it "should redirect to the opinion" do
        do_put
        response.should redirect_to(opinion_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @opinion.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /opinions/1" do

    before(:each) do
      @opinion = mock_model(Opinion, :destroy => true)
      Opinion.stub!(:find).and_return(@opinion)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the opinion requested" do
      Opinion.should_receive(:find).with("1").and_return(@opinion)
      do_delete
    end
  
    it "should call destroy on the found opinion" do
      @opinion.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the opinions list" do
      do_delete
      response.should redirect_to(opinions_url)
    end
  end
end