require 'kimurai'
require 'pry'

class EightydaysSpider < Kimurai::Base
    @name = "eightydays_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://www.eighty-days.com/join-us/"]
    @config = {
        disable_images: true
    }

    def parse(response, url:, data: {})

        # find the correct Organisation
        org_id = Organisation.where(organisation_name: '80 Days').first.id
        org = Organisation.find(org_id)

        jobs_count = response.css('div.listing').count

        returned_jobs = response.css('div.careers-listing')
        
        returned_jobs.css('div.listing').each do |element|

            title = element.css('h2').text.strip

            location = "Edinburgh"

            details_url = element.css('a').first["href"]

            full_details_url = "https://www.eighty-days.com/join-us/" + details_url

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
