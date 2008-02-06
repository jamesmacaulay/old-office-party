require 'appscript'

module Itunes
  
  
  class <<self
    include Appscript
    
    def party_shuffle(options = {})
      instance.playlists[its.special_kind.eq(:Party_Shuffle)].first.tracks.
          get_properties(options[:properties] || default_track_properties)
    end
  
    def search(query, options={})
      first = options[:offset] || 0
      last = options[:limit] ? first + options[:limit] : -1
      instance.search(app.library_playlists.first, :for => query)[first..last].map do |track|
        track.get_properties(options[:properties] || default_track_properties).first
      end
    end
  
    def find_track(persistent_id, options={})
      tracks = instance.library_playlists.first.tracks[its.persistent_ID.eq(persistent_id)].first.
          get_properties(options[:properties] || default_track_properties)
      return tracks.first
    end
    
    def rate_track!(persistent_id, rating)
      instance.library_playlists.first.tracks[its.persistent_ID.eq(persistent_id)].first.
          rating.set(rating)
    end
    
    def current_track(options={})
      instance.current_track.get_properties(options[:properties] || default_track_properties).first
    end
    
    def current_track_end_time
      return nil unless playing?
      duration = instance.current_track.duration.get.round
      position = instance.player_position.get
      Time.now + duration - position
    end
    
    def last_updated_at
      File.mtime(File.join(ENV['HOME'], 'Music', 'iTunes', 'iTunes Library'))
    end
    
    def playing?
      instance.player_state.get == :playing
    end
    
    def play!
      instance.play
    end
    
    def pause!
      instance.pause
    end
    
    def playpause!
      instance.playpause
    end
    
    def next_track!
      instance.next_track
    end
    
    def previous_track!
      instance.previous_track
    end
    
    def player_position
      pos = instance.player_position.get
      pos == :missing_value ? nil : pos
    end
    
    def player_position=(val)
      instance.player_position.set(val)
    end
  
    private
  
    def default_track_properties
      [:persistent_ID, :name, :artist, :album, :duration, :rating, :modification_date]
    end
  
    def instance
      (itunes = app('itunes')).get
      return itunes
    end
  end
end