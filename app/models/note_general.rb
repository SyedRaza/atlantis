class NoteGeneral < ActiveRecord::Base
   has_attached_file :attachment
   has_one :notes, :as => :detail
end
