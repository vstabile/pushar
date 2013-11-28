class CreatePusharApps < ActiveRecord::Migration
  def change
    create_table :pushar_apps do |t|
      t.string :name, :null => false
      t.string :platform, :null => false
      t.text :apn_dev_cert
      t.text :apn_prod_cert
      t.text :apn_app_key
      t.text :gcm_api_key
      t.text :adm_api_key
      t.text :adm_client_id
      t.text :adm_client_secret
      t.integer :devices_count, :default => 0
      t.integer :inactive_devices_count, :default => 0

      t.timestamps
    end

    add_index :pushar_apps,  :platform
  end
end
