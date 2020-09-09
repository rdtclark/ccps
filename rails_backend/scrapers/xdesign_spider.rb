require 'kimurai'
require 'pry'

class XdesignSpider < Kimurai::Base
    @name = "xdesign_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://www.xdesign.com/careers/"]
    @config = {
        disable_images: true,
    }

    def parse(response, url:, data: {})

        # find the correct Organisation
        org_id = Organisation.where(organisation_name: 'xDesign').first.id
        org = Organisation.find(org_id)

        no_vacancies_message = "No Openings Currently"

        # add job scraper here

        # update vacancies_listed at Organisation if no jobs listed
        if response.css('div.jobs-container h2').text.strip == no_vacancies_message
            org.vacancies_listed = false
            org.save!
        else
            org.vacancies_listed = true
            org.save!
        end
    end
end