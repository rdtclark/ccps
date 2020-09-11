require 'kimurai'
require 'pry'

class DufrainSpider < Kimurai::Base
  @name = "dufrain_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://www.dufrain.co.uk/careers"]
  @config = {
    disable_images: true,
    delay: 4..7
  }


    def parse(response, url:, data: {})


        returned_jobs = response.css('div.columns medium-7 box1-lbox-content')

        returned_jobs.css('li').each do |element|

            title = element.css('a').text.strip
            # location is in the title
            # location = 

            details_url = element.css('a').first["href"]

            org_id = Organisation.where(organisation_name: 'Dufrain').first.id

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: details_url
            )
        end
    end
end
