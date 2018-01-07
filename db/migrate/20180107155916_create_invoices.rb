class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.belongs_to :order, foreign_key: true
      t.string :status
      t.integer :total
      t.text :product_ids, array: true

      t.timestamps
    end
  end
end
