require 'kimurai'
require 'pry'

class CranewareSpider < Kimurai::Base
    @name = "craneware_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://careers.craneware.com/"]
    @config = {
        disable_images: true
    }

    def parse(response, url:, data: {})

        # find the correct Organisation
        org_id = Organisation.where(organisation_name: 'Craneware').first.id
        org = Organisation.find(org_id)

        #jobs_count = response.css('div.user-journey-card-body').count

        returned_jobs = response.css('tbody#j_id0:j_id1:j_id48:j_id157:j_id158:j_id166:tb')

        binding.pry
        
        returned_jobs.css('tr').each do |element|

            # title = element.css('h2').text.strip

            # location = 

            # details_url = element.css('a').first["href"]


            # Job.where(organisation_id: org_id, title: title).first_or_create(
            #     organisation_id: org_id,
            #     title: title,
            #     location: location,
            #     details_url: details_url
            # )
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
