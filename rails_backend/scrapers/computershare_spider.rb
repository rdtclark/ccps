require 'kimurai'
require 'pry'

class ComputershareSpider < Kimurai::Base
    @name = "computershare_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://cpu.taleo.net/careersection/ex/jobsearch.ftl?f=LOCATION(3300101387)"]
    @config = {
        disable_images: true
    }


    # def scrape_page
    #     doc = browser.current_response
    #     returned_jobs = doc.css('table#jobs')
    #     returned_jobs.css('li').each do |element|
    #         title = element.css('div.multiline-data-container a').text.strip

    #         location = element.css('span.initial-locations').text.strip

    #         details_url = element.css('span a')["href"]
    #     end

    # end


    def parse(response, url:, data: {})


        # find the correct Organisation
        org_id = Organisation.where(organisation_name: 'Computershare').first.id
        org = Organisation.find(org_id)

        binding.pry

        browser.refresh

        response = browser.current_response

        returned_jobs = response.css('table#jobs') 

        jobs_count = returned_jobs.css('li').count
        
        returned_jobs.css('li').each do |element|

            title = element.css('div.multiline-data-container a').text.strip

            location = element.css('span.initial-locations').text.strip

            details_url = element.css('span a')["href"]

            full_details_url = "https://cpu.taleo.net/" + details_url

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: full_details_url
            )
        end

        # update vacancies_listed at Organisation if no jobs listed
        if jobs_count > 0
            org.vacancies_listed = true
            org.save!
        else
            org.vacancies_listed = false
            org.save!
            org.vacancies_listed = false
            org.save!
        end
    end
end
