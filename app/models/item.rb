class Item < ApplicationRecord
  validates_presence_of [:title, :plot]
end
