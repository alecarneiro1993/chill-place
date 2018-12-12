class Season < ApplicationRecord
 has_many :episodes
 validates_presence_of [:title, :plot]
end
