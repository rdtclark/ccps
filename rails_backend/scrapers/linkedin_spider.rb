require 'kimurai'
require 'pry'

class LinkedinSpider < Kimurai::Base
    @name = "linkedin_spider"
    @engine = :selenium_chrome
    @start_urls = Organisation.linkedin_job_urls[0..20]
    @config = {
        disable_images: true,
        delay: 4..7
    }

    def parse(response, url:, data: {})

        returned_jobs = response.css('ul.jobs-search__results-list')
        
        returned_jobs.css('li').each do |element|


            title = element.css('h3').text.strip

            location = element.css('span.job-result-card__location').text.strip

            details_url = element.css('a').first["href"]

            Job.where(title: title).first_or_create(
                organisation_id: 58,
                title: title,
                location: location,
                details_url: details_url
            )
        end

    end
end
