class PartyShuffleController < ApplicationController
  include AuthenticatedSystem
  helper_method :update_after_xhr
  
  def show
    @user = current_user
    @user = nil if @user == :false
    @tracks = Track.load_party_shuffle
    @current_track = Track.current || @tracks[5]
    @player_position = Track.player_position.to_i
    @playing = Itunes.playing?
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => {:current_track => @current_track, :tracks => @tracks, :player_position => @player_position, :playing => @playing}.to_xml }
      format.js
    end
  end
  
  def control
    case params[:command]
    when 'play': Itunes.play!
    when 'pause': Itunes.pause!
    when 'playpause': Itunes.playpause!
    when 'previous_track': Itunes.previous_track!
    when 'next_track' : Itunes.next_track!
    when 'set_player_position' : Itunes.player_position = params[:val].to_i
    end
    
    redirect_to :action => 'show', :format => 'js'
  end
  
end
