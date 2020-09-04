class AddOrganisationToJobs < ActiveRecord::Migration[6.0]
  def change
    add_reference :jobs, :organisation, null: false, foreign_key: true
  end
end
