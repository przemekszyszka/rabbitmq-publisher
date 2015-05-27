class RenameRateToRates < ActiveRecord::Migration
  def change
    rename_column :currencies, :rate, :rates
  end
end
