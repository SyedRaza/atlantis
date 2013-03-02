class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads do |t|
      t.text :primary_skills
      t.text :situation
      t.text :original_email
      t.integer :company_id
      t.integer :contact_id
      t.integer :lead_status_id
      t.integer :lead_type_id
      t.integer :lead_source_id

      t.timestamps
    end
  end

  def self.down
    drop_table :leads
  end
end
