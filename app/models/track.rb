class Track < ActiveRecord::Base
  has_many :opinions
  has_many :users, :through => :opinions
  
  @@cache_updated_at = nil
  @@current_track_end_time = nil
  @@cached_responses = {}
  
  class <<self
    
    def player_position
      if (@@current_track_end_time ||= Itunes.current_track_end_time)
        current[:duration] - (@@current_track_end_time - Time.now)
      else
        itunes_cache 'Track.player_position', 1 do
          Itunes.player_position
        end
      end
    end
    
    def load_party_shuffle
      cache_time = if @@cache_updated_at and @@current_track_end_time
        @@current_track_end_time - @@cache_updated_at
      else
        3
      end
      itunes_cache 'Track.load_party_shuffle', 1.hour do
        @@current_track_end_time = Itunes.current_track_end_time
        hashes = Itunes.party_shuffle
        hashes.map do |hash|
          update_track(hash)
        end
      end
    end
    
    # options hash takes :limit and :offset
    def search_itunes(query, options={})
      itunes_cache "Track.search(#{query.inspect},#{options.inspect})", 1.hour do
        Itunes.search(query, options).map {|hash| update_track(hash) }
      end
    end
    
    def current
      cache_time = if @@cache_updated_at and @@current_track_end_time
        @@current_track_end_time - @@cache_updated_at
      else
        3
      end
      itunes_cache 'Track.current', cache_time do
        @@current_track_end_time = Itunes.current_track_end_time
        update_track(Itunes.current_track)
      end
    end
    
    
    #######
    private
    #######
    
    def update_track(hash)
      return nil if hash.blank?
      modification_date = hash.delete('modification_date')
      track = find_or_initialize_by_persistent_id(hash.delete('persistent_id'))
      track.update_attributes(hash) if track.needs_updating?(modification_date)
      track
    end
    
    def itunes_cache(key, time, &block)
      now = Time.now
      if @@cached_responses.has_key?(key) and
            @@cache_updated_at and
            @@cache_updated_at + time > now and
            @@cache_updated_at > Itunes.last_updated_at
        return @@cached_responses[key]
      else
        @@cache_updated_at = now
        @@cached_responses.clear
        return (@@cached_responses[key] = yield)
      end
    end
    
  end
  
  ######
  public
  ######
  
  def current?
    self == self.class.current
  end
  
  def needs_updating?(modification_date = nil)
    modification_date = Itunes.find_track(self.persistent_id)['modification_date'] if modification_date.nil?
    return true unless persistent_id and updated_at and modification_date
    modification_date > self.updated_at
  end
  
  def update_from_itunes
    new_attributes = Itunes.find_track(persistent_id, :properties => [:name, :artist, :album, :duration, :rating])
    update_attributes(new_attributes)
  end
  
  def save_rating_to_itunes
    Itunes.rate_track!(persistent_id, rating)
  end
  

end
