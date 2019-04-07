class AddDefaultEnabledToItems < ActiveRecord::Migration[5.1]
  def change
        change_column :items, :enabled, :boolean, :default => true
      end
    end
