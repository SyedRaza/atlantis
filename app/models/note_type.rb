class NoteType < ActiveRecord::Base
  #has_ancestry
  acts_as_list
  belongs_to :user


end
