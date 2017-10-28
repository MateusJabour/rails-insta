class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    enable_extension "citext"

    create_table :users, id: :uuid do |t|
      t.string :name
      t.citext :username, null: false
      t.string :password_digest, null: false
      t.citext :email, null: false

      t.string :biography
			t.string :website
      t.string :phone_number
      t.string :gender

      t.boolean :is_private, null: false, default: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
