#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "vteams"
},
{
  :order => [:id, :name, :dm, :developers, :technologies, :created_at, :updated_at, :user_id, :intent_to_start, :start_date, :flag_id, :spcl_note, :key_dates, :bill_approved, :billmode_id, :vteamstatus_id, :startup_advice, :workinghours, :lead_id]
}

pre_process :truncate, :target => :development, :table => 'vteams'
before_write :check_unique, :keys => [:id, :name, :dm, :developers, :technologies, :created_at, :updated_at, :user_id, :intent_to_start, :start_date, :flag_id, :spcl_note, :key_dates, :bill_approved, :billmode_id, :vteamstatus_id, :startup_advice, :workinghours, :lead_id]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :name, :dest => :name
after_read :copy_field, :source => :dm, :dest => :dev_manager
after_read :copy_field, :source => :developers, :dest => :developers
after_read :copy_field, :source => :technologies, :dest => :technologies
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at
after_read :copy_field, :source => :user_id, :dest => :user_id
after_read :copy_field, :source => :intent_to_start, :dest => :intent_to_start
after_read :copy_field, :source => :start_date, :dest => :start_date
after_read :copy_field, :source => :flag_id, :dest => :flag_id
after_read :copy_field, :source => :spcl_note, :dest => :special_note
after_read :copy_field, :source => :key_dates, :dest => :key_dates
after_read :copy_field, :source => :bill_approved, :dest => :approved_on
after_read :copy_field, :source => :billmode_id, :dest => :billing_mode_id
after_read :copy_field, :source => :vteamstatus_id, :dest => :vteam_status_id
after_read :copy_field, :source => :startup_advice, :dest => :startup_advice
after_read :copy_field, :source => :workinghours, :dest => :working_hours
after_read :copy_field, :source => :lead_id, :dest => :lead_id




destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "vteams"
},
{
  :order => [:id, :name, :dev_manager, :developers, :technologies, :created_at, :updated_at, :user_id, :intent_to_start, :start_date, :flag_id, :special_note, :key_dates, :approved_on, :billing_mode_id, :vteam_status_id, :startup_advice, :working_hours, :lead_id]
}