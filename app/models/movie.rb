class Movie < ApplicationRecord
  validates_presence_of [:title, :plot]
  has_many :purchases, as: :purchasable
end
