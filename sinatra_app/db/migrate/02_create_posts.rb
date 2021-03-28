class CreatePosts < ActiveRecord::Migration[4.2]
    def change
      create_table :posts do |t|
        t.string :content
        t.integer :user_id
      end
    end
  end