class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos, id: :uuid do |t|
      t.text :description
      t.belongs_to :user, foreign_key: true, type: 'uuid'

      t.timestamps null: false
    end
  end
end
