#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "phonedetails",
  :conditions => "phone !=''"
},
{
  :order => [:id, :parent_id, :phonetype_id, :phone, :created_at, :updated_at, :parent_type]
}

pre_process :truncate, :target => :development, :table => 'phones'
before_write :check_unique, :keys => [:id, :parent_id, :phonetype_id, :phone, :created_at, :updated_at, :parent_type]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :parent_id, :dest => :phoneable_id
after_read :copy_field, :source => :phonetype_id, :dest => :phone_type_id
after_read :copy_field, :source => :phone, :dest => :phone_number
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at
after_read :copy_field, :source => :parent_type, :dest => :phoneable_type

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "phones"
},
{
  :order => [:id, :phone_number, :phone_type_id, :phoneable_id, :phoneable_type, :created_at, :updated_at]
}