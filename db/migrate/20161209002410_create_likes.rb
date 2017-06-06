class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes, id: :uuid do |t|
      t.references :photo, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps null: false
    end
  end
end
