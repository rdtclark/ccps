class CreateOrganisations < ActiveRecord::Migration[6.0]
  def change
    create_table :organisations do |t|
      t.string :organisation_name
      t.string :industry
      t.string :roles_within_company
      t.string :location
      t.boolean :job_page_exists
      t.string :job_page_url
      t.string :homepage
      t.string :about
      t.string :linkedin
      t.boolean :open_to_spec_app
      t.string :email

      t.timestamps
    end
  end
end
