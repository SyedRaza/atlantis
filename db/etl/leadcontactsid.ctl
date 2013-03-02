#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "contacts, leads",
  :conditions => "contacts.firstname = leads.first_name AND contacts.lastname = leads.last_name",
  :select => "contacts.id, contacts.firstname, contacts.lastname, leads.first_name, leads.last_name, leads.id as leadid"
},
{
  :order => [:id, :firstname, :lastname, :first_name, :last_name, :leadid]
}
after_read :copy_field, :source => :id, :dest => :contact_id
before_write :check_unique, :keys => [:leadid]

destination :out, {
  :type => :database,
  :target => :development,
  :database => "leads"
},
{
  :order => [:id, :firstname, :lastname, :first_name, :last_name, :leadid]
}