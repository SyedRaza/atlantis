#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "xdoctypes"
},
{
  :order => [:id, :title, :user_id]
}

pre_process :truncate, :target => :development, :table => 'note_types'
before_write :check_unique, :keys => [:title]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :title, :dest => :title
after_read :copy_field, :source => :user_id, :dest => :user_id


destination :out, {
  :type => :database,
  :target => :development,
  :database => "atlantis_development",
  :table => "note_types"
},
{
  :order => [:id, :title, :user_id]
}