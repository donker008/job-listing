class JobsController < ApplicationController


  def index

    @q = Job.ransack(params[:q])

    @jobs = case params[:order]
        when 'by_default'
          @jobs = @q.result(distinct: true).order(updated_at: :DESC).page(params[:page])
        when 'by_max_salary'
          @jobs = @q.result(distinct: true).order(salaryMax: :DESC).page(params[:page])
        when 'by_min_salary'
          @jobs = @q.result(distinct: true).order(salaryMin: :DESC).page(params[:page])
        else
          @jobs = @q.result(distinct: true).order(created_at: :DESC).page(params[:page])
      end
    @workplaces = Workplace.all
    @industries = Industry.all

  end

  def show
    # render plain: params.inspect
    @job = Job.find(params[:id])
    if @job.hide
      redirect_to jobs_path
    end
  end

  def new
    flash[:warning] = "You cant create job!"
    redirect_to jobs_path
  end

  def create
    flash[:warning] = "You cant create job!"
    redirect_to jobs_path
  end

  def edit
    flash[:warning] = "You cant edit job!"
    redirect_to jobs_path
  end

  def destroy
    flash[:warning] = "You cant delete job!"
    redirect_to jobs_path
  end

  def search
    @q = Job.ransack(params[:q])
    order  = params[:order]
    orderType = ''
    if order.blank? || order == 'by_default'
      @jobs = @q.result(distinct: true).includes(:company).order(updated_at: :DESC).page(params[:page])
    elsif order == 'by_new'
      @jobs = @q.result(distinct: true).includes(:company).order(created_at: :DESC).page(params[:page])
    elsif order == 'by_min_salary'
      @jobs = @q.result(distinct: true).includes(:company).order(salaryMin: :DESC).page(params[:page])
    elsif order == 'by_max_salary'
      @jobs = @q.result(distinct: true).includes(:company).order(salaryMax: :DESC).page(params[:page])
    end
    respond_to do |format|
      # format.html
      format.js
    end
  end

end
