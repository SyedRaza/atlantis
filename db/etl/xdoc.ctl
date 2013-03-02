#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "xdocdetails"
},
{
  :order => [:id, :xdoctype_id, :parent_id, :parent_type, :user_id, :created_at, :updated_at]
}

pre_process :truncate, :target => :development, :table => 'notes'

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :xdoctype_id, :dest => :note_type_id
after_read :copy_field, :source => :parent_id, :dest => :parent_id
after_read :copy_field, :source => :parent_type, :dest => :parent_type
after_read :copy_field, :source => :user_id, :dest => :user_id
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at

destination :out, {
  :type => :database,
  :target => :development,
  :database => "atlantis_development",
  :table => "notes"
},
{
  :order => [:id, :note_type_id, :parent_id, :parent_type, :user_id, :created_at, :updated_at]
}