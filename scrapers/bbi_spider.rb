require 'kimurai'
require 'pry'

class BbiSpider < Kimuari::Base
    @name = 'bbi_spider'
    @engine = :selenium_chrome
    @start_urls = ["https://www.the-bbigroup.com/careers/our-vacancies/"]
    @config = {
        disable_images: true
    }

    def parse(response, url:, data: {})

        returned_jobs = response.css('div.entry-content')

        returned_jobs.css('table.vacancytable').each do |element|

            title = element.css('a').text.strip

            location = element.css('tr').text.strip

            if element.css

    end


end

#id 26