require 'sidekiq-scheduler'

class ScrapeLinkedin
  include Sidekiq::Worker
  sidekiq_options retry: :false

  def perform
    # Delete all jobs older than 14 days
    Job.delete_all("created_at < ?', '#{14.days.ago}'")

    # run the spider
    LinkedinSpider.crawl!
  end
end