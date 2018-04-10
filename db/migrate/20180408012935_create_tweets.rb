class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.text :content

      t.timestamps
    end

    add_index :tweets, :created_at, unique: false
  end
end
