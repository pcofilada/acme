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
end
