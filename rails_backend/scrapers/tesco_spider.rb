require 'kimurai'
require 'pry'

class TescoSpider < Kimurai::Base
    @name = "tesco_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://ldd.tbe.taleo.net/ldd03/ats/careers/searchResults.jsp?org=TESCO&cws=1&location=1"]
    @config = {
        disable_images: true
    }

    #start_url link had to be updated as tesco bank used an iframe

    def parse(response, url:, data: {})

        returned_jobs = response.css('table#cws-search-results')

        returned_jobs.css('tr').drop(1).each do |element|

            title = element.css('td')[0].text.strip

            details_url = element.css('td a').first["href"]

            location = element.css('td')[1].text.strip

            org_id = Organisation.where(organisation_name: 'Tesco Bank').first.id

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: details_url
            )
        
        end
    end
end