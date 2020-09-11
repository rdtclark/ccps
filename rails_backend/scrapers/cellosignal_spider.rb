require 'kimurai'
require 'pry'

class CellosignalSpider < Kimurai::Base
  @name = "cellosignal_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://cellosignal.com/careers"]
  @config = {
    disable_images: true,
    delay: 4..7
  }

# Cello Signal

    def parse(response, url:, data: {})

        # find the correct Organisation
        org_id = Organisation.where(organisation_name: 'Appointedd').first.id
        org = Organisation.find(org_id)

        no_vacancies_message = "Sorry, we don't have any vacancies right now"

        # add job scraper here

        # update vacancies_listed at Organisation if no jobs listed
        if response.css('h3.heading styles__StyledHeader-sc-1fh0z6j-1 iaRtxE Heading-sc-2wi0dg-0 etzcfm').text.strip == no_vacancies_message
            org.vacancies_listed = false
            org.save!
        else
            org.vacancies_listed = true
            org.save!
        end
    end
