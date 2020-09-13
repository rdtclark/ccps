require 'kimurai'
require 'pry'

class LinkedinSpider < Kimurai::Base
    @name = "linkedin_spider"
    @engine = :selenium_chrome
    @start_urls = Organisation.linkedin_job_urls.sample(1)
    @config = {
        disable_images: true,
        before_request: {
            delay: 3..6
        }
    }

    def parse(response, url:, data: {})

        # grab the organisation name from the current URL
        marker1 = "&id="
        marker2 = "&redirect"
        org_id = url[/#{marker1}(.*?)#{marker2}/m, 1]

        # find the correct Organisation
        org = Organisation.find(org_id)

        returned_jobs = response.css('ul.jobs-search__results-list')

        jobs_count = returned_jobs.css('li').count
        
        returned_jobs.css('li').each do |element|

            title = element.css('h3').text.strip

            location = element.css('span.job-result-card__location').text.strip

            details_url = element.css('a').first["href"]

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: 58,
                title: title,
                location: location,
                details_url: details_url
            )
        end

        if jobs_count > 0
            org.vacancies_listed = true
            org.save!
        else
            org.vacancies_listed = false
            org.save!
            org.vacancies_listed = false
            org.save!
        end

    end
end
