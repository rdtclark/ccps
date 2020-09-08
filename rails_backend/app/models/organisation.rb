class Organisation < ApplicationRecord
    has_many :jobs
    scope :with_about, -> { where.not(about: [nil, ""]) }
    scope :with_linkedin, -> { where.not(linkedin: [nil, ""]) }
    scope :with_job_page_url, -> { where.not(job_page_url: [nil, ""]) }
    scope :with_open_to_spec_app, -> { where.not(open_to_spec_app: [nil, ""]) }
    scope :with_homepage, -> { where.not(homepage: [nil, ""]) }
end
