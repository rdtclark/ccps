require 'kimurai'
require 'pry'

class LinkedinSpider < Kimurai::Base
    @name = "linkedin_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://uk.linkedin.com/jobs/search?keywords=Junior%20Software%20Engineer&location=Edinburgh%2C%20Scotland%2C%20United%20Kingdom&geoId=&trk=public_jobs_jobs-search-bar_search-submit&redirect=false&position=1&pageNum=0"]
    @config = {
        disable_images: true
    }

    def parse(response, url:, data: {})

        # find the correct Organisation
        # org_id = Organisation.where(organisation_name: 'AutoRek').first.id
        # org = Organisation.find(org_id)

        #jobs_count = response.css('div.careers-table__row').count

        returned_jobs = response.css('ul.jobs-search__results-list')
        
        returned_jobs.css('li').each do |element|

            binding.pry

            title = element.css('h3').text.strip

            location = element.css('span.job-result-card__location').text.strip

            details_url = element.css('a').first["href"]

            #full_details_url = "https://autorek.com" + details_url

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: full_details_url
            )
        end

        # update vacancies_listed at Organisation if no jobs listed
        # if jobs_count > 0
        #     org.vacancies_listed = true
        #     org.save!
        # else
        #     org.vacancies_listed = false
        #     org.save!
        #     org.vacancies_listed = false
        #     org.save!
        # end
    end
end
