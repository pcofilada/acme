class HomepageController < ApplicationController
  require 'csv'

  def index
    @histories    = History.order(created_at: :desc)
    @object_types = History.pluck(:historyable_type).uniq
  end

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

    redirect_to root_path
  end

  def filter
    filter_params = ActionController::Parameters.new(params_json(params))

    @histories = History.filter(filter_params)

    respond_to do |format|
      format.js
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

  def params_json(params)
    timestamp = params[:timestamp]

    {
      historyable_type: params[:object_type],
      historyable_id: params[:id],
      created_at: timestamp.present? ? Time.strptime(timestamp, '%s') : ''
    }
  end
end
