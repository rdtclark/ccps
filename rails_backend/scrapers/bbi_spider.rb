require 'kimurai'
require 'pry'

class BbiSpider < Kimurai::Base
    @name = "bbi_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://www.the-bbigroup.com/careers/our-vacancies/"]
    @config = {
        disable_images: true
    }

    def parse(response, url:, data: {})

        returned_jobs = response.css('table#vacancytable')

        returned_jobs.css('tr').drop(1).each do |element|

            title = element.css('td')[1].text.strip

            details_url = element.css('td a').first["href"]

            location = element.css('td')[2].text.strip

            org_id = Organisation.where(organisation_name: 'BBI Group').first.id

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: details_url
            )
        end
    end
end