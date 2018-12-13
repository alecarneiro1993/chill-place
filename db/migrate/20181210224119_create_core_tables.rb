class CreateCoreTables < ActiveRecord::Migration[5.1]
  def change

    create_table :movies do |t|
      t.string :title
      t.text :plot
      t.timestamps
    end

    create_table :seasons do |t|
      t.string :title
      t.text :plot
      t.timestamps
    end

    create_table :episodes do |t|
      t.string :title
      t.text :plot
      t.integer :episode_number
      t.references :season, foreign_key: true
      t.timestamps
    end
  end
end
