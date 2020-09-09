require 'kimurai'
require 'pry'

class DeliverooSpider < Kimurai::Base
    @name = "deliveroo_spider"
    @engine = :selenium_chrome
    @start_urls = ["https://careers.deliveroo.co.uk/?country=london&remote=&remote=true&team=engineering-team#filter-careers"]
    @config = {
        disable_images: true
    }

    def parse(response, url:, data: {})

        # find the correct Organisation
        org_id = Organisation.where(organisation_name: "Deliveroo (formerly Cultivate Software Ltd)").first.id
        org = Organisation.find(org_id)

        returned_jobs = response.css('ul.careers-listings')

        jobs = returned_jobs.css('li')

        jobs_count = jobs.count

        jobs.drop(1).each do |element|
            
            title = element.css('h3').text.strip

            location = element.css('p.careers-opportunity__location').text.strip

            details_url = element.css('a').first["href"]

            Job.where(organisation_id: org_id, title: title).first_or_create(
                organisation_id: org_id,
                title: title,
                location: location,
                details_url: details_url
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