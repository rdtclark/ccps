class Organisation < ApplicationRecord
    has_many :jobs
    scope :with_about, -> { where.not(about: [nil, ""]) }
    scope :with_linkedin, -> { where.not(linkedin: [nil, ""]) }
    scope :with_job_page_url, -> { where.not(job_page_url: [nil, ""]) }
    scope :with_open_to_spec_app, -> { where.not(open_to_spec_app: [nil, ""]) }
    scope :with_homepage, -> { where.not(homepage: [nil, ""]) }

    def self.update_has_scraper
        orgs = Organisation.where(organisation_name: [
            "CodeClan", 
            "2i Testing",
            "Airts",
            "deltaDNA",
            "AutoRek",
            "Gecko Engage",
            "Tesco Bank",
            "BBI Group",
            "Bad Dinosaur",
            "Deliveroo (formerly Cultivate Software Ltd)"
        ])

        orgs.each do |org|
            org.has_scraper = true
            org.save!
        end
    end
end
