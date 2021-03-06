require 'kimurai'
require 'pry'
require 'bundler'
Bundler.require

Kimurai.configure do |config|
  config.selenium_chrome_path = ENV['SELENIUM_CHROME_PATH'].presence
  config.chromedriver_path = ENV['CHROMEDRIVER_PATH'].presence
end

class LinkedinSpider < Kimurai::Base
  # PROXIES = [Rails.application.credentials.res1_proxy[:address], Rails.application.credentials.res2_proxy[:address]]
  @name = "linkedin_spider"
  @engine = :selenium_chrome
  @start_urls = Organisation.linkedin_job_urls.sample(150)
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    disable_images: true,
    # proxy: -> { PROXIES.sample },
    proxy: Rails.application.credentials.res3_proxy[:address],
    session: {
      recreate_driver_if: {
        # Restart browser if provided memory limit (in kilobytes) is exceeded:
        memory_size: 750_000
      }
    },
    before_request: {
      delay: 5..44,
      change_proxy: true
    }
  }

  def parse(response, url:, data: {})

    # grab the organisation name from the current URL
    marker1 = "&id="
    marker2 = "&redirect"
    org_id = url[/#{marker1}(.*?)#{marker2}/m, 1]

    # find the correct Organisation
    org = Organisation.find(org_id)

    returned_jobs = response.css('ul.jobs-search__results-list')

    jobs_count = returned_jobs.css('li').count

    returned_jobs.css('li').each do |element|

      title = element.css('h3').text.strip

      location = element.css('span.job-result-card__location').text.strip

      details_url = element.css('a').first["href"]

      Job.where(organisation_id: org_id, title: title).first_or_create(
        organisation_id: org_id,
        title: title,
        location: location,
        details_url: details_url
      )
    end

    if jobs_count > 0
      org.vacancies_listed = true
      org.save!
    else
      org.vacancies_listed = false
      org.save!
    end
  end
end
