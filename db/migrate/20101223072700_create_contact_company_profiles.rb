class CreateContactCompanyProfiles < ActiveRecord::Migration
  def self.up
    create_table :contact_company_profiles do |t|
      t.integer :contact_id
      t.integer :company_id
      t.date :active_date
      t.date :expire_date
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_company_profiles
  end
end
