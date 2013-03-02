class CreateWebsiteTypes < ActiveRecord::Migration
  def self.up
    create_table :website_types do |t|
      t.string :website_type

      t.timestamps
    end
  end

  def self.down
    drop_table :website_types
  end
end
