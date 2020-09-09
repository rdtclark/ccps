require 'kimurai'
require 'pry'

class CodeclanSpider < Kimurai::Base
  @name = "codeclan_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://codeclan.com/about-us/join-us/"]
  @config = {
    disable_images: true,
  }

  def parse(response, url:, data: {})

    returned_jobs = response.css('div.elementor-element-108d375')

    returned_jobs.css('div.elementor-row').each do |element|

        title = element.css('h2.elementor-heading-title').text.strip

        details_url = element.css('a').first["href"]
        full_details_url = "https://codeclan.com/about-us/join-us/" + details_url
        
        location = "Scotland"

        org_id = Organisation.where(organisation_name: 'CodeClan').first.id

        Job.where(organisation_id: org_id, title: title).first_or_create(
        organisation_id: org_id,
        title: title,
        location: location,
        details_url: full_details_url
        )
        end
    end
end