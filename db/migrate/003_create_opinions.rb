class CreateOpinions < ActiveRecord::Migration
  def self.up
    create_table :opinions do |t|
      t.integer :user_id
      t.integer :track_id
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :opinions
  end
end
