class AddEeoEnabledToApplicationDrafts < ActiveRecord::Migration
  def change
    add_column :application_drafts, :eeo_enabled, :boolean, default: true
  end
end