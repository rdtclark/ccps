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
            "Deliveroo (formerly Cultivate Software Ltd)",
            "80 Days",
            "Craneware",
            "Moon Collider (Kytheria.AI)",
            "Dufrain"
        ])

        orgs.each do |org|
            org.has_scraper = true
            org.save!
        end
    end

    def self.linkedin_job_urls
        orgs = Organisation.all

        job_urls = []

        orgs.each do |org|
            param = org.organisation_name.parameterize(separator: '%20', preserve_case: true)
            org_id = org.id
            url = "https://uk.linkedin.com/jobs/search?keywords=%22#{param}%22&location=Edinburgh%2C%20Scotland%2C%20United%20Kingdom&geoId=100209086&trk=public_jobs_jobs-search-bar_search-submit&id=#{org_id}&redirect=false&position=1&pageNum=0"
            job_urls << url
        end

        return job_urls
    end
end
