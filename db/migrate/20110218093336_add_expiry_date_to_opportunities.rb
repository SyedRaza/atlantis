class AddExpiryDateToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :expiry_date, :date
  end

  def self.down
    remove_column :opportunities, :expiry_date
  end
end
