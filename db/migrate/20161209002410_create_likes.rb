class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes, id: :uuid do |t|
      t.belongs_to :photo, foreign_key: true, type: :uuid
      t.belongs_to :user, foreign_key: true, type: :uuid

      t.timestamps null: false
    end
  end
end
