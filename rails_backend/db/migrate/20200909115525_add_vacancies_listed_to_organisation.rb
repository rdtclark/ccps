class AddVacanciesListedToOrganisation < ActiveRecord::Migration[6.0]
  def change
    add_column :organisations, :vacancies_listed, :boolean
  end
end
