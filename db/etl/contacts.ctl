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
  :order => [:id, :firstname, :lastname, :title, :info, :status_id, :type_id, :directory_id, :user_id, :created_at, :updated_at]
}

pre_process :truncate, :target => :development, :table => 'contacts'
before_write :check_unique, :keys => [:id, :firstname, :lastname, :title, :info, :status_id, :type_id, :directory_id, :user_id, :created_at, :updated_at]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :firstname, :dest => :first_name
after_read :copy_field, :source => :lastname, :dest => :last_name
after_read :copy_field, :source => :title, :dest => :title
after_read :copy_field, :source => :info, :dest => :additional_info
after_read :copy_field, :source => :status_id, :dest => :contact_status_id
after_read :copy_field, :source => :type_id, :dest => :contact_type_id
after_read :copy_field, :source => :directory_id, :dest => :contact_directory_id
after_read :copy_field, :source => :user_id, :dest => :user_id
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at



destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "contacts"
},
{
  :order => [:id, :first_name, :last_name, :title, :additional_info, :contact_status_id, :contact_type_id, :contact_directory_id, :user_id, :created_at, :updated_at]
}