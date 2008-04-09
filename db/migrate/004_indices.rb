class Indices < ActiveRecord::Migration
  def self.up
    add_index :opinions, :track_id
    add_index :opinions, :user_id
    add_index :tracks, :persistent_id
  end

  def self.down
    remove_index :opinions, :track_id
    remove_index :opinions, :user_id
    remove_index :tracks, :persistent_id
  end
end
