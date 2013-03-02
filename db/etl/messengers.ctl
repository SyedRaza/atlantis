#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "messengerdetails",
  :conditions => "messenger !=''"
},
{
  :order => [:id, :parent_id, :messengertype_id, :messengeroption_id, :messenger, :created_at, :updated_at, :parent_type]
}

pre_process :truncate, :target => :development, :table => 'messengers'
before_write :check_unique, :keys => [:id, :parent_id, :messengertype_id, :messenger, :created_at, :updated_at, :parent_type]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :parent_id, :dest => :messengerable_id
after_read :copy_field, :source => :messengertype_id, :dest => :messenger_type_id
after_read :copy_field, :source => :messengeroption_id, :dest => :messenger_service_id
after_read :copy_field, :source => :messenger, :dest => :title
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at
after_read :copy_field, :source => :parent_type, :dest => :messengerable_type

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "messengers"
},
{
  :order => [:id, :title, :messenger_type_id, :messenger_service_id, :messengerable_id, :messengerable_type, :created_at, :updated_at]
}