class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :customer_address
      t.string :status
      t.date :ship_date
      t.string :shipping_provider

      t.timestamps
    end
  end
end
