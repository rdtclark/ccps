class JobsController < ApplicationController
    before_action :set_job, only: [:show]

  # /jobs
  def index
    @jobs = Job.all
    @jobs_data = []
    @jobs.each do |job|
      org_name = {"organisation_name" => job.organisation.organisation_name}
      job = JSON::parse(job.to_json).merge(org_name)
      @jobs_data << job
    end
    render json: @jobs_data
  end

  # jobs/:id
  def show
    # render json: @job
  render json: @job.attributes.merge({
    organisation_name: @job.organisation.organisation_name })
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end
end
