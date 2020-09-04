require 'kimurai'
require 'pry'

class TwoiSpider < Kimurai::Base
  @name = "twoi_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://2itesting.com/vacancy/current-opportunities?p=1",
                 "https://2itesting.com/vacancy/current-opportunities?p=2"]
  @config = {
    disable_images: true
  }

  def parse(response, url:, data: {})

    returned_jobs = response.css('div.vacancy-list')

    returned_jobs.css('div.vacancy-listing').each do |element|

      title = element.css('h3 a').text.strip

      location = element.css('p').text.strip

      if element.css('span.job-label')[1].text.strip == "City:"
        location = element.css('div.job-info')[1].text.strip
        location.slice! "City: "
      else
        location = nil
      end

      details_url = element.css('h3 a').first["href"]

      full_details_url = "https://2itesting.com" + details_url

      org_id = Organisation.where(organisation_name: '2i Testing').first.id


      Job.where(organisation_id: org_id, title: title).first_or_create(
        organisation_id: org_id,
        title: title,
        location: location,
        details_url: full_details_url
      )
    end
  end
end
