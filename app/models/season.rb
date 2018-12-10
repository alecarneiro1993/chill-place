class Season < Item
 has_many :episodes, foreign_key: :item_id
end
