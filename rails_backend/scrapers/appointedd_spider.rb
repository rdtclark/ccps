require 'kimurai'
require 'pry'

class AppointeddSpider < Kimurai::Base
    @name = "appointedd_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://www.appointedd.com/jobs"]
    @config = {
        disable_images: true,
    }

    def parse(response, url:, data: {})

        # find the correct Organisation
        org_id = Organisation.where(organisation_name: 'Appointedd').first.id
        org = Organisation.find(org_id)

        no_vacancies_message = "We’re not currently recruiting – thanks for checking. We’ll announce on social media when we open new roles."

        # add job scraper here

        # update vacancies_listed at Organisation if no jobs listed
        if response.css('h2 a').text.strip == no_vacancies_message
            org.vacancies_listed = false
            org.save!
        else
            org.vacancies_listed = true
            org.save!
        end
    end
end