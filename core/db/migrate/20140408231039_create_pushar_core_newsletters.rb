class CreatePusharCoreNewsletters < ActiveRecord::Migration
  def change
    create_table :pushar_core_newsletters do |t|
      t.string :name, :null => :false
      t.integer :send_count, :default => 0, :null => :false
      t.integer :open_count, :default => 0, :null => :false
      t.datetime :sent_at

      t.timestamps
    end
  end
end
