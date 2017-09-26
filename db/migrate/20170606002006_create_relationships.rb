class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships, id: :uuid do |t|
      t.uuid :follower_id, foreign_key: true
      t.uuid :followed_id, foreign_key: true

      t.boolean :accepted, null: false, default: false

      t.timestamps null: false
    end

    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
