require 'kimurai'
require 'pry'

class DayshapeSpider < Kimurai::Base
  @name = "dayshape_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://dayshape.com/careers"]
  @config = {
    disable_images: true,
    delay: 4..7
  }

  def parse(response, url:, data: {})

    sleep 2

    returned_jobs = response.css('div#bzOpeningsContainer')

    returned_jobs.css('li.bzOpening').each do |element|

      title = element.css('h2').text.strip

      location = element.css('li.bzLocation').text.strip

      details_url = element.css('a').first["href"]

      org_id = Organisation.where(organisation_name: 'Airts').first.id

      Job.where(organisation_id: org_id, title: title).first_or_create(
        organisation_id: org_id,
        title: title,
        location: location,
        details_url: details_url
      )
    end
  end
end
