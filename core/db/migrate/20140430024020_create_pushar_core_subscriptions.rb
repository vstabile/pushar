class CreatePusharCoreSubscriptions < ActiveRecord::Migration
  def change
    create_table :pushar_core_subscriptions do |t|
      t.string :email
      t.integer :send_count, :default => 0, :null => :false
      t.integer :open_count, :default => 0, :null => :false
      t.datetime :last_opened_at

      t.timestamps
    end
  end
end
