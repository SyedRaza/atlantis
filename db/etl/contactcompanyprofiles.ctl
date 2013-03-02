#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "contacts"
},
{
  :order => [:id, :company_id]
}

pre_process :truncate, :target => :development, :table => 'contact_company_profiles'
before_write :check_unique, :keys => [:id, :company_id]

after_read :copy_field, :source => :id, :dest => :contact_id
after_read :copy_field, :source => :company_id, :dest => :company_id

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "contact_company_profiles"
},
{
  :order => [:contact_id, :company_id]
}