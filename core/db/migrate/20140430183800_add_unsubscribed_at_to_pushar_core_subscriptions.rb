class AddUnsubscribedAtToPusharCoreSubscriptions < ActiveRecord::Migration
  def change
    add_column :pushar_core_subscriptions, :unsubscribed_at, :datetime
  end
end
