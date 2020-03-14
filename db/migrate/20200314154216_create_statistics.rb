class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.integer :restaurant_id
      t.float :average_rating
      t.integer :count_ratings

      t.timestamps
    end
  end
end
