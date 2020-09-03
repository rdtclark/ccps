require 'kimurai'
require 'pry'

class AutorekSpider < Kimurai::Base
    @name = "autorek_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://www.autorek.com/about-autorek/about/careers"]
    @config = {
        disable_images: true
    }

    attr_accessor :jobs
    def parse(response, url:, data: {})
        @jobs = []

        jobs_count = response.css('div.careers-table__row').count

        returned_jobs = response.css('div.container')
       
        returned_jobs.css('div.careers-table__row').each do |element|

            title = element.css('h2.table__title').text.strip

            location = element.css('p').text.strip

            details_url = element.css('a.text-link').first["href"]
            full_details_url = "https://autorek.com" + details_url

            # job = {
            #     title: title,
            #     location: location,
            #     details_url: full_details_url
            # }

            Job.create(
                title: title,
                location: location,
                details_url: full_details_url
            )
        end
    end
end