require 'kimurai'
require 'pry'

class GeckoSpider < Kimurai::Base
    @name = "gecko"
    @engine = :selenium_chrome
    @start_urls = ["https://careers.geckoengage.com/"]
    @config = {
        disable_images: true
    }


    def parse(response, url:, data: {})

        returned_jobs = response.css('div.jobs-container')


        jobs = returned_jobs.css('a.col-md-6')

        # exclude the last element -2, start from first element 0 (Gecko Engage has a 'Dream role' listing in their vacancies).
        jobs[0..-2].each_with_index do |element, i|

            title = element.css('h5.title').text.strip

            details_url = element["href"]
            full_details_url = "https://careers.geckoengage.com/" + details_url

            location = element.css('div.city').text.strip

            org_id = Organisation.where(organisation_name: 'Gecko Engage').first.id

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: full_details_url
            )
        end
    end
end