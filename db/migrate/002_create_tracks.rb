class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :persistent_id
      t.string :name
      t.string :artist
      t.string :album
      t.float :duration
      t.integer :rating
      t.boolean :enabled, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
