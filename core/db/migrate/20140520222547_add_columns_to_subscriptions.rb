class AddColumnsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :pushar_core_subscriptions, :unsubscribe_reason, :string
  end
end
