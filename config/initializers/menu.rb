#MenuManagerthis template, choose Tools | Templates
# and open the template in the editor.

#Atlantis::MenuManager.add_menu_item :application_menu, :dashboard, { :controller => 'dashboard'.to_sym, :action => :index }, {:caption => 'Dashboard'}

Atlantis::MenuManager.add_menu_item :application_menu, :dashboard, { :controller=>"/dashboard", :action=>:index }, {:caption => 'Dashboard' }
#Atlantis::MenuManager.add_menu_item :application_menu, :dashboard_xdocs, { :controller=>"/dashboard", :action=>:index }, {:caption => 'Graphs', :parent=>:dashboard }
#Atlantis::MenuManager.add_menu_item :application_menu, :dashboard_xdocs, { :controller=>"/dashboard", :action=>:notes }, {:caption => 'Notes', :parent=>:dashboard }

Atlantis::MenuManager.add_menu_item :application_menu, :leads, { :controller=>"/leads", :action=>:index }, {:caption => 'Leads' }
#Atlantis::MenuManager.add_menu_item :application_menu, :leads_list, { :controller=>"/leads", :action=>:index }, {:caption => 'List All Leads', :parent=>:leads }
#Atlantis::MenuManager.add_menu_item :application_menu, :new_lead, { :controller=>"/leads", :action=>:new }, {:caption => 'New Lead', :parent=>:leads }

Atlantis::MenuManager.add_menu_item :application_menu, :opportunities, { :controller=>"/opportunities", :action=>:index }, {:caption => 'Opportunities' }
#Atlantis::MenuManager.add_menu_item :application_menu, :opportunities_list, { :controller=>"/opportunities", :action=>:index }, {:caption => 'List All Opportunities', :parent=>:opportunities }
#Atlantis::MenuManager.add_menu_item :application_menu, :new_opportunity, { :controller=>"/opportunities", :action=>:new }, {:caption => 'New Opportunity', :parent=>:opportunities }

Atlantis::MenuManager.add_menu_item :application_menu, :vteams, { :controller=>"/vteams", :action=>:index }, {:caption => 'VTeams' }
#Atlantis::MenuManager.add_menu_item :application_menu, :vteams_list, { :controller=>"/vteams", :action=>:index }, {:caption => 'List All VTeams', :parent=>:vteams }
#Atlantis::MenuManager.add_menu_item :application_menu, :new_vteam, { :controller=>"/vteams", :action=>:new }, {:caption => 'New VTeam', :parent=>:vteams }


Atlantis::MenuManager.add_menu_item :application_menu, :placements, { :controller=>"/placements", :action=>:index }, {:caption => 'Placements' }
#Atlantis::MenuManager.add_menu_item :application_menu, :placements_list, { :controller=>"/placements", :action=>:index }, {:caption => 'List All Placements', :parent=>:placements }
#Atlantis::MenuManager.add_menu_item :application_menu, :new_placement, { :controller=>"/placements", :action=>:new }, {:caption => 'New Placement', :parent=>:placements }

Atlantis::MenuManager.add_menu_item :application_menu, :meetings, { :controller=>"/meetings", :action=>:index }, {:caption => 'Meetings' }
#Atlantis::MenuManager.add_menu_item :application_menu, :meeting_list, { :controller=>"/meetings", :action=>:index }, {:caption => 'List All Meetings', :parent=>:meetings }
#Atlantis::MenuManager.add_menu_item :application_menu, :new_meeting, { :controller=>"/meetings", :action=>:new }, {:caption => 'New Meeting', :parent=>:meetings }


Atlantis::MenuManager.add_menu_item :application_menu, :companies, { :controller=>"/companies", :action=>:index }, {:caption => 'Companies' }
#Atlantis::MenuManager.add_menu_item :application_menu, :company_list, { :controller=>"/companies", :action=>:index }, {:caption => 'List All Companies', :parent=>:companies }
#Atlantis::MenuManager.add_menu_item :application_menu, :company_lead, { :controller=>"/companies", :action=>:new }, {:caption => 'New Company', :parent=>:companies }

Atlantis::MenuManager.add_menu_item :application_menu, :contacts, { :controller=>"/contacts", :action=>:index }, {:caption => 'Contacts' }
#Atlantis::MenuManager.add_menu_item :application_menu, :contact_list, { :controller=>"/contacts", :action=>:index }, {:caption => 'List All Contacts', :parent=>:contacts }
#Atlantis::MenuManager.add_menu_item :application_menu, :contact_lead, { :controller=>"/contacts", :action=>:new }, {:caption => 'New Contact', :parent=>:contacts }


#Atlantis::MenuManager.add_menu_item :application_menu, :configurations, { :controller=>:configurations, :action=>:index }, {:caption => 'Configurations' }
#Atlantis::MenuManager.add_menu_item :application_menu, :configurations_general, { :controller=>:configurations, :action=>:general }, {:caption => 'General' , :parent => :configurations}
#Atlantis::MenuManager.add_menu_item :application_menu, :configurations_leads, { :controller=>:configurations, :action=>:leads }, {:caption => 'Leads' , :parent => :configurations}
#Atlantis::MenuManager.add_menu_item :application_menu, :configurations_user, { :controller=>:configurations, :action=>:user }, {:caption => 'User' , :parent => :configurations}
#Atlantis::MenuManager.add_menu_item :application_menu, :configurations_plugins, { :controller=>:configurations, :action=>:plugins }, {:caption => 'Plugins' , :parent => :configurations}
#Atlantis::MenuManager.add_menu_item :application_menu, :configurations_authorization, { :controller=>:configurations, :action=>:authorization }, {:caption => 'Authorization' , :parent => :configurations}

#
#Atlantis::MenuManager.add_menu_item :application_menu, :temps2, { :controller=>:temps, :action=>:index }, {:caption => 'Temps' }
#
#Atlantis::MenuManager.add_menu_item :application_menu, :temp_list2, { :controller=>:temps, :action=>:index }, {:caption => 'list temps', :parent=>:temps2 }
#Atlantis::MenuManager.add_menu_item :application_menu, :temp_new2, { :controller=>:temps, :action=>:new }, {:caption => 'new temps', :parent=>:temps2 }
