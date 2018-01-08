class HomepageController < ApplicationController
  before_action :set_object_types, except: :import

  def index
    @histories = History.order(created_at: :desc).page(params[:page])
  end

  def import
    HistoryUploadWorker.perform_async(params[:file].path)

    redirect_to root_path
  end

  def filter
    filter_params = ActionController::Parameters.new(params_json(params))

    @histories = History.filter(filter_params)
    @histories = @histories.page(params[:page])

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  private

  def set_object_types
    @object_types = History.pluck(:historyable_type).uniq
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
