class Organisation < ApplicationRecord
    has_many :jobs
    scope :with_about, -> { where.not(about: [nil, ""]) }
    scope :with_linkedin, -> { where.not(linkedin: [nil, ""]) }
    scope :with_job_page_url, -> { where.not(job_page_url: [nil, ""]) }
    scope :with_open_to_spec_app, -> { where.not(open_to_spec_app: [nil, ""]) }
    scope :with_homepage, -> { where.not(homepage: [nil, ""]) }

    def self.linkedin_job_urls
        orgs = Organisation.all

        job_urls = []

        orgs.each do |org|
            param = org.organisation_name.parameterize(separator: '%20', preserve_case: true)
            org_id = org.id
            ## f_I= Industry
            # 2C96 = Information Technology & Services
            # 4 = Computer Software
            url = "https://uk.linkedin.com/jobs/search?f_I=4%2C96&keywords=%22#{param}%22&location=Scotland%2C%20United%20Kingdom&geoId=&trk=public_jobs_jobs-search-bar_search-submit&id=#{org_id}&redirect=false&position=1&pageNum=0"
            job_urls << url
        end

        return job_urls
    end
end