class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.string :quality
      t.integer :purchasable_id
      t.string :purchasable_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
