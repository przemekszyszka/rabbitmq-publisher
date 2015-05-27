class CreateCurrencies < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    create_table :currencies, id: :uuid do |t|
      t.json :rate
      t.boolean :processed_by_consumer_1
      t.boolean :processed_by_customer_2
      t.boolean :processed_by_customer_3

      t.timestamps null: false
    end
  end
end
