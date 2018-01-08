class History < ApplicationRecord
  belongs_to :historyable, polymorphic: true

  def self.import_from_csv(item, object_changes, timestamp)
    create(
      historyable: item,
      object_changes: object_changes,
      created_at: timestamp,
      updated_at: timestamp
    )
  end

  def self.filter(params)
    results = order(created_at: :desc)

    params.each do |key, value|
      results = results.where(key.to_sym => value) if value.present?
    end

    results
  end

  def timestamp
    created_at.strftime('%b %d, %Y %I:%M:%S %p')
  end
end
