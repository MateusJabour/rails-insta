class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.belongs_to :photo, foreign_key: true, type: 'uuid'
      t.belongs_to :user, foreign_key: true, type: 'uuid'
      t.text :text, null: false

      t.timestamps null: false
    end
  end
end
