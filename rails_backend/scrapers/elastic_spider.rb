require 'kimurai'
require 'pry'

class ElasticSpider < Kimurai::Base
  @name = "elastic_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://elasticcreative.co.uk/careers/"]
  @config = {
    disable_images: true,
    delay: 4..7
  }

# Elastic

    def parse(response, url:, data: {})

        # find the correct Organisation
        org_id = Organisation.where(organisation_name: 'Appointedd').first.id
        org = Organisation.find(org_id)

        no_vacancies_message = "There are currently no vacancies available but we fully expect to be hiring again soon."
        cv_submit_message = "Should you like to send over your CV, and where relevant, any examples of your work please email&nbsp;"

        # add job scraper here

        # update vacancies_listed at Organisation if no jobs listed
        if response.css('div.wpb_wrapper p').text.strip == no_vacancies_message || cv_submit_message
            org.vacancies_listed = false
            org.save!
        else
            org.vacancies_listed = true
            org.save!
        end
    end