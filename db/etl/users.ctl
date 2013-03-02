#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "users"
},
{
  :order => [:id, :login, :crypted_password, :salt, :created_at, :updated_at, :first_name]
}

pre_process :truncate, :target => :development, :table => 'users'
before_write :check_unique, :keys => [:id, :login, :crypted_password, :salt, :created_at, :updated_at, :first_name]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :login, :dest => :email
after_read :copy_field, :source => :crypted_password, :dest => :encrypted_password
after_read :copy_field, :source => :salt, :dest => :password_salt
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at
after_read :copy_field, :source => :first_name, :dest => :name

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "users"
},
{
  :order => [:id, :email, :encrypted_password, :password_salt, :created_at, :updated_at, :name]
}