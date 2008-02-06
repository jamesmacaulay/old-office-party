class OpinionsController < ApplicationController
  include AuthenticatedSystem
  # GET /opinions
  # GET /opinions.xml
  def index
    @opinions = Opinion.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @opinions }
    end
  end

  # GET /opinions/1
  # GET /opinions/1.xml
  def show
    @opinion = Opinion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @opinion }
    end
  end

  # GET /opinions/new
  # GET /opinions/new.xml
  def new
    @opinion = Opinion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @opinion }
    end
  end

  # GET /opinions/1/edit
  def edit
    @opinion = Opinion.find(params[:id])
  end

  # POST /opinions
  # POST /opinions.xml
  def create
    @opinion = Opinion.find_or_initialize_by_user_id_and_track_id(params[:user_id], params[:track_id])
    @opinion.rating = params[:rating]

    respond_to do |format|
      if @opinion.save
        flash[:notice] = 'Opinion was successfully created.'
        format.html { redirect_to(@opinion) }
        format.xml  { render :xml => @opinion, :status => :created, :location => @opinion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @opinion.errors, :status => :unprocessable_entity }
      end
      format.js {session[:current_track_id] = nil; redirect_to :controller => 'party_shuffle', :action => 'show', :format => 'js'}
    end
  end

  # PUT /opinions/1
  # PUT /opinions/1.xml
  def update
    @opinion = Opinion.find_or_initialize_by_user_id_and_track_id(params[:user_id], params[:track_id])

    respond_to do |format|
      if @opinion.update_attributes(params[:opinion])
        flash[:notice] = 'Opinion was successfully updated.'
        format.html { redirect_to(@opinion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @opinion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /opinions/1
  # DELETE /opinions/1.xml
  def destroy
    @opinion = Opinion.find(params[:id])
    @opinion.destroy

    respond_to do |format|
      format.html { redirect_to(opinions_url) }
      format.xml  { head :ok }
    end
  end
end
