class CreatePusharNotificationOptions < ActiveRecord::Migration
  def change
    create_table :pushar_core_notification_options do |t|
      t.string :key
      t.string :value
      t.integer :notification_id

      t.timestamps
    end

    remove_column :pushar_core_notifications, :message
    remove_column :pushar_core_notifications, :options

    add_index :pushar_core_notification_options, :notification_id
  end
end
