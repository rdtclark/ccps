require 'kimurai'
require 'pry'

class BaddinosaurSpider < Kimurai::Base
    @name = "baddinosaur_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://www.baddinosaur.co.uk/Careers"]
    @config = {
        disable_images: true
    }

    def parse(response, url:, data: {})

        # find the correct Organisation
        org_id = Organisation.where(organisation_name: 'Bad Dinosaur').first.id
        org = Organisation.find(org_id)

        jobs_count = response.css('div.user-journey-card-body').count

        returned_jobs = response.css('div.bg-white')
        
        returned_jobs.css('div.user-journey-card-body').each do |element|

            title = element.css('h2').text.strip

            location = "Edinburgh"

            details_url = element.css('a').first["href"]


            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: details_url
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
