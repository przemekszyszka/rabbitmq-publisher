class RenameColumnsProcessedByInCurrencies < ActiveRecord::Migration
  def change
    rename_column :currencies, :processed_by_customer_2, :processed_by_consumer_2
    rename_column :currencies, :processed_by_customer_3, :processed_by_consumer_3
  end
end
