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

        no_vacancies_message = "We’re not currently recruiting – thanks for checking. We’ll announce on social media when we open new roles."

        if response.css('h2 a').text.strip == no_vacancies_message
            vacancies = false
        else
            vacancies = true
        end

        binding.pry

        org_id = Organisation.where(organisation_name: 'Appointedd').first.id
        

    end
end