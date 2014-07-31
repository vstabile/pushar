class CreatePusharCoreNotifications < ActiveRecord::Migration
  def change
    create_table :pushar_core_notifications do |t|
      t.string :message
      t.string :options
      t.integer :app_id, :null => false
      t.datetime :sent_at

      t.timestamps
    end

    add_index :pushar_core_notifications, :app_id
  end
end
