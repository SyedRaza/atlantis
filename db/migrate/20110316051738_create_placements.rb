class CreatePlacements < ActiveRecord::Migration
  def self.up
    create_table :placements do |t|
      t.date :date_effective
      t.text :available_resources
      t.text :freeing_up_resources
      t.text :reserved_resources

      t.timestamps
      t.references :user
      
    end
  end

  def self.down
    drop_table :placements
  end
end
