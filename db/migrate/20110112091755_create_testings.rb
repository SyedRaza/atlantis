class CreateTestings < ActiveRecord::Migration
  def self.up
    create_table :testings do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :testings
  end
end
