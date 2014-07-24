class AddTenantIdToSubscription < ActiveRecord::Migration
  def change
    add_column :pushar_core_subscriptions, :tenant_id, :integer

    add_index :pushar_core_subscriptions, :tenant_id
  end
end
