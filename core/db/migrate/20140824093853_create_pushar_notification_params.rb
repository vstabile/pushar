class CreatePusharNotificationParams < ActiveRecord::Migration
  def change
    create_table :pushar_core_notification_params do |t|
      t.string :key
      t.string :value
      t.integer :notification_id, :null => :false

      t.timestamps
    end
    
    add_index :pushar_core_notification_params, :notification_id
  end
end
