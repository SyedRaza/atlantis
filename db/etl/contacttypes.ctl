#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "contacttypes"
},
{
  :order => [:id, :title, :created_at, :updated_at]
}

pre_process :truncate, :target => :development, :table => 'contact_types'
before_write :check_unique, :keys => [:id, :title, :created_at, :updated_at]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :title, :dest => :contact_type
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "contact_types"
},
{
  :order => [:id, :contact_type, :created_at, :updated_at]
}