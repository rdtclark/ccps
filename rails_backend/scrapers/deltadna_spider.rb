require 'kimurai'
require 'pry'

class DeltadnaSpider < Kimurai::Base
    @name = "deltadna_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://careers.unity.com/find-position?location=edinburgh",
    "https://careers.unity.com/find-position?location=dundee"]
    @config = {
        disable_images: true
    }

    def parse(response, url:, data: {})

        returned_jobs = response.css('div#all-positions')

        returned_jobs.css('div.component-open-positions__position').each do |element|

            

            if element.css('a').first["data-location"] == "edinburgh"

                title = element.css("div.component-open-positions__list-position-title").text.strip
                
                details_url = element.css('a').first["href"]
                full_details_url = "https://careers.unity.com" + details_url
                
                location = element.css("div.component-open-positions__list-position-location").text.strip

                org_id = Organisation.where(organisation_name: "deltaDNA").first.id

                Job.where(organisation_id: org_id, title: title).first_or_create(
                    organisation_id: org_id,
                    title: title,
                    location: location,
                    details_url: details_url
                )

            else

            end
        end
    end
end