#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "leads"
},
{
  :order => [:id, :leadsource_id, :user_id, :leadtype_id, :orginalemail, :leadstatus_id, :skillset, :situation, :created_at, :updated_at]
}


pre_process :truncate, :target => :development, :table => 'leads'
before_write :check_unique, :keys => [:id]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :leadsource_id, :dest => :lead_source_id
after_read :copy_field, :source => :user_id, :dest => :user_id
after_read :copy_field, :source => :leadtype_id, :dest => :lead_type_id
after_read :copy_field, :source => :originalemail, :dest => :original_email
after_read :copy_field, :source => :leadstatus_id, :dest => :lead_status_id
after_read :copy_field, :source => :skillset, :dest => :primary_skills
after_read :copy_field, :source => :situation, :dest => :situation
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at


destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "leads"
},
{
  :order => [:id, :lead_source_id, :user_id, :lead_type_id, :original_email, :lead_status_id, :primary_skills, :situation, :created_at, :updated_at]
}




