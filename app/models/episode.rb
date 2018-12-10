class Episode < Item
  belongs_to :season, foreign_key: :item_id
end
