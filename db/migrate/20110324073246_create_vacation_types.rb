class CreateVacationTypes < ActiveRecord::Migration
  def self.up
    create_table :vacation_types do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :vacation_types
  end
end
