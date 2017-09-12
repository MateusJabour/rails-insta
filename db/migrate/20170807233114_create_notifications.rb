class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.uuid :user_id, foreign_key: true
      t.uuid :notified_user_id, foreign_key: true
      t.text :text, null: false
      t.text :subject, null: false
      t.uuid :target_id, null: false

      t.timestamps null: false
    end
  end
end
