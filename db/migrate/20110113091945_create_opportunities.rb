class CreateOpportunities < ActiveRecord::Migration
  def self.up
    create_table :opportunities do |t|
      t.string :title
      t.integer :opportunity_type_id
      t.integer :opportunity_status_id
      t.date :created_effective
      t.string :seats
      t.string :experience
      t.text :skill_area
      t.references :source, :polymorphic  => true
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :opportunities
  end
end
