#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "leadstatuses"
},
{
  :order => [:id, :name, :created_at, :updated_at]
}

pre_process :truncate, :target => :development, :table => 'lead_statuses'
before_write :check_unique, :keys => [:id, :status, :created_at, :updated_at]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :name, :dest => :status
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at


destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "lead_statuses"
},
{
  :order => [:id, :status, :created_at, :updated_at]
}