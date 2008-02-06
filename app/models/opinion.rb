class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :track
  
  validates_uniqueness_of :track_id, :scope => :user_id
  after_save :save_average_rating_to_itunes
  
  private
  
  def save_average_rating_to_itunes
    other_ratings = self.class.find_all_by_track_id(track_id).map(&:rating)
    Itunes.rate_track!(track.persistent_id, other_ratings.sum / other_ratings.length)
    track.update_from_itunes
  end
end
