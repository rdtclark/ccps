class AddHasScraperToOrganisation < ActiveRecord::Migration[6.0]
  def change
    add_column :organisations, :has_scraper, :boolean
  end
end
