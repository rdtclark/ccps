require 'kimurai'
require 'pry'

class KytheraSpider < Kimurai::Base
    @name = "kythera_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://www.kythera.ai/recruitment"]
    @config = {
        disable_images: true,
    }


    def parse(response, url:, data: {})


        org_id = Organisation.where(organisation_name: 'Moon Collider (Kytheria.AI)').first.id
        org = Organisation.find(org_id)

        jobs_count = response.css('div.sqs-block').count

        response.css('div.sqs-block').each do |element|
            
            title = element.css('h1 strong').text.strip

            location = "Edinburgh"

            details_url = element.css('a').[1]["href"]

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: details_url
            )
        end
    end
end
