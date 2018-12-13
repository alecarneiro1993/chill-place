class Season < ApplicationRecord
 has_many :episodes
 validates_presence_of [:title, :plot]
 has_many :purchases, as: :purchasable
end
