# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def format_duration(seconds)
    seconds = seconds.to_i
    hours = seconds / 60 / 60
    minutes = seconds / 60 % 60
    seconds = seconds % 60 % 60
    string = ''
    string << "%02d:" % hours if hours > 0
    string << "%#{'02' if hours > 0}d:%02d" % [minutes, seconds]
  end
  
  def play_or_pause_button(playing, logged_in = false)
    image = image_tag("control_#{playing ? 'pause' : 'play'}.png", :size => "16x16", :alt=> (playing ? 'pause' : 'play'), :title => (playing ? 'pause' : 'play'))
    !logged_in? ? image : link_to_remote(image, :url => {:action => 'control', :command => (playing ? 'pause' : 'play')}, :after => "timeToUpdate=true;")
  end
  
  def user_rating_for(user, track)
    if user.nil?
      0
    else
      opinion = user.opinions.find_by_track_id(track.id)
      opinion.nil? ? 0 : opinion.rating || 0
    end
  end
  
  def rating_stars(user, current_track, rating = nil)
    user_rating = rating || user_rating_for(user, current_track)
    words = ['one','two','three','four','five']
    (1..5).map do |num|
      name = words[num - 1] + ' star' + (num > 1 ? 's' : '')
      outlined = user_rating > (num * 20 - 10)
      image = image_tag("star#{'-outline' if outlined}.png", :size => "65x65", :id => "current_track_star_#{num}", :alt => name, :title => (user.nil? ? 'you could rate this track if you were logged in' : "rate this track #{name}"), :onmouseover => "resetCurrentTrackUserStars(#{num})", :onmouseout => "resetCurrentTrackUserStars(null)" )
      user.nil? ? image : link_to_remote(image, :url => {:controller => 'opinions', :action => 'create', :track_id => current_track.id, :user_id => user.id, :rating => num * 20})
    end
  end
end
