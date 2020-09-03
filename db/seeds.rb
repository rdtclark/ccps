# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CSV.foreach(Rails.root.join('lib/CCPS.csv'), headers: true) do |row|


    if row[4] == "Y"
        row[4] = true
    else
        row[4] = false
    end

    if row[11] == "Y"
        row[11] = true
    else
        row[11] = false
    end

    Organisation.create({
        organisation_name: row[0],
        industry: row[1],
        roles_within_company: row[2],
        location: row[3],
        job_page_exists: row[4],
        job_page_url: row[5],
        homepage: row[6],
        about: row[7],
        linkedin: row[8],
        open_to_spec_app: row[11],
        email: row[12]
    })
end