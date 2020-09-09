require 'kimurai'
require 'pry'

class AutorekSpider < Kimurai::Base
    @name = "autorek_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://www.autorek.com/about-autorek/about/careers"]
    @config = {
        disable_images: true
    }

    def parse(response, url:, data: {})

        # find the correct Organisation
        org_id = Organisation.where(organisation_name: 'AutoRek').first.id
        org = Organisation.find(org_id)

        jobs_count = response.css('div.careers-table__row').count

        returned_jobs = response.css('div.container')
        
        returned_jobs.css('div.careers-table__row').each do |element|

            title = element.css('h2.table__title').text.strip

            location = element.css('p').text.strip

            details_url = element.css('a.text-link').first["href"]

            full_details_url = "https://autorek.com" + details_url

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: full_details_url
            )
        end

        # update vacancies_listed at Organisation if no jobs listed
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
