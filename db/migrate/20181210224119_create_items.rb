class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.text :plot
      t.references :item, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
