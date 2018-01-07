class HomepageController < ApplicationController
  require 'csv'

  def import
    CSV.foreach(params[:file].path, headers: true) do |row|
      object    = row.to_hash
      item      = get_item(object)

      History.import_from_csv(
        item,
        JSON.parse(object['object_changes']),
        Time.strptime(object['timestamp'], '%s')
      )
    end
  end

  private

  def get_item(object)
    item     = object['object_type']
               .constantize.where(id: object['object_id'])
               .first_or_create
    order_id = JSON.parse(object['object_changes'])['order_id']
    order    = Order.find_by(id: order_id) if order_id

    associate_invoice(item, order) if item.class == Invoice && order

    item
  end

  def associate_invoice(invoice, order)
    invoice.update(order: order)
  end
end
