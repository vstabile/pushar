class CreatePusharCoreDevices < ActiveRecord::Migration
  def change
    create_table :pushar_core_devices do |t|
      t.integer :user_id
      t.string :token, :null => false
      t.integer :app_id, :null => false
      t.string :locale
      t.datetime :inactivated_at
      t.boolean :banner
      t.boolean :badge
      t.boolean :sound
      t.string :app_name
      t.string :app_version
      t.string :os_name
      t.string :os_version
      t.string :device_name
      t.string :device_version

      t.timestamps
    end

    add_index :pushar_core_devices, :user_id
    add_index :pushar_core_devices, :app_id
  end
end
