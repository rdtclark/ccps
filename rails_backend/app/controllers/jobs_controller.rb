class JobsController < ApplicationController
    before_action :set_job, only: [:show]

  # /jobs
  def index
    org = Job.all
    render json: org
  end

  # jobs/:id
  def show
    render json: @job
  end

  private

  def set_org
    @job = Job.find(params[:id])
  end
end
