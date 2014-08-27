class AddNotificationsCountToApp < ActiveRecord::Migration
  def change
    add_column :pushar_core_apps, :notifications_count, :integer, :default => 0
  end
end
