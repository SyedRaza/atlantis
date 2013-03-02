#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "messengeroptions"
},
{
  :order => [:id, :title, :created_at, :updated_at]
}

pre_process :truncate, :target => :development, :table => 'messenger_services'
before_write :check_unique, :keys => [:id, :title, :created_at, :updated_at]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :title, :dest => :service
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "messenger_services"
},
{
  :order => [:id, :service, :created_at, :updated_at]
}