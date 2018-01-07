class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.jsonb :object_changes
      t.references :historyable, polymorphic: true

      t.timestamps
    end

    add_index :histories, :object_changes, using: :gin
  end
end
