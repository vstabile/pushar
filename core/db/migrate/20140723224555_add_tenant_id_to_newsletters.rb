class AddTenantIdToNewsletters < ActiveRecord::Migration
  def change
  	add_column :pushar_core_newsletters, :tenant_id, :integer

    add_index :pushar_core_newsletters, :tenant_id
  end
end
