#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "opportunities"
},
{
  :order => [:id, :user_id, :parent_type, :parent_id, :position_title, :seats, :skillarea, :exp, :note, :opportunitystatus_id, :placementtype_id, :created_at, :updated_at, :created_eff]
}

pre_process :truncate, :target => :development, :table => 'opportunities'
before_write :check_unique, :keys => [:id, :user_id, :parent_type, :parent_id, :position_title, :seats, :skillarea, :exp, :note, :opportunitystatus_id, :placementtype_id, :created_at, :updated_at, :created_eff]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :user_id, :dest => :user_id
after_read :copy_field, :source => :parent_type, :dest => :source_type
after_read :copy_field, :source => :parent_id, :dest => :source_id
after_read :copy_field, :source => :position_title, :dest => :title
after_read :copy_field, :source => :seats, :dest => :seats
after_read :copy_field, :source => :skillarea, :dest => :skill_area
after_read :copy_field, :source => :exp, :dest => :experience
after_read :copy_field, :source => :note, :dest => :note
after_read :copy_field, :source => :opportunitystatus_id, :dest => :opportunity_status_id
after_read :copy_field, :source => :placementtype_id, :dest => :opportunity_type_id
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at
after_read :copy_field, :source => :created_eff, :dest => :created_effective



destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "opportunities"
},
{
  :order => [:id, :user_id, :source_type, :source_id, :title, :seats, :skill_area, :experience, :note, :opportunity_status_id, :opportunity_type_id, :created_at, :updated_at, :created_effective]
}