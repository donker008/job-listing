class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :upate, :destory,:publish, :hide]
  before_action :require_is_admin
  layout  "admin"
  def index
    @jobs = Job.where(:user_id => current_user.id).all.order("created_at DESC")
    isUserDashBoard = params[:isUserDashBoard]
    if !isUserDashBoard.blank? && isUserDashBoard
        @isUserDashBoard = true
    end
  end

  def new
    @job = Job.new
    @company = Company.where(user_id: current_user.id).limit(1).first
    if @company.blank?
      flash[:warning] = "发布工作岗位前，请先提交公司信息"
      redirect_to new_company_path
    end
    @academics = Academic.all
    @workplaces = Workplace.all
  end

  def create

    @job = Job.new(job_params)
    @job.user_id = current_user.id
    company = Company.where(:user_id =>current_user.id).limit(1).first
    if company.blank?
      flash[:warning] = "请先创建公司信息"
      redirect_to new_company_path
    end
    @job.company_id = company.id
    if @job.save
      flash[:notice] = "Create job successful."
      redirect_to admin_jobs_path
    else
      flash[:alert] = "Failed to create job. Error:" + @job.errors.full_messages.to_s
      render :new
    end
    # redirect_to admin_jobs_patAcademicsh
  end

  def edit
    @job = Job.find(params[:id])
    make_sure_job_right(@job)
    if @job.blank?
      flash[:alert] = "Job don't exist"
      redirect_to admin_jobs_path
    end
    @academics = Academic.all
    @workplaces = Workplace.all
  end

  def update
    @job = Job.find(params[:id])
    make_sure_job_right(@job)
    if @job.update(job_params)
      flash[:notice] = "Update Job successful."
      redirect_to admin_jobs_path
    else
      flash[:error] = "Failed to update job."
       render :edit
    end
  end

  def show

    @job = Job.find(params[:id])
    make_sure_job_right(@job)
    if @job.hide
      redirect_to admin_jobs_path
    end
    @industries = Industry.all;
  end


  def destroy
    @job = Job.find(params[:id])
    make_sure_job_right(@job)
    if @job.blank?

      flash[:warning] = "Failed to remove job, can't find job."
      redirect_to admin_jobs_path
    else
      @job.delete
      flash[:notice] = "Delete job successful."
      redirect_to admin_jobs_path
    end

  end

  def publish
    if current_user && current_user.is_admin?
      show_job(true)
    else
      flash[:warning] = "You dont have right to do this action"
      redirect_to admin_jobs_path
    end
  end

  def hide
    if current_user && current_user.is_admin?
      show_job(false)
    else
      flash[:warning] = "You dont have right to do this action"
      redirect_to jobs_path
    end

  end

  def resumes
    job_id = Job.find(params[:job_id])
    @resumes = Resume.where(:job_id => job_id).order("created_at DESC")
  end


  private


  def show_job(bshow)
    @job = Job.find(params[:job_id])
    @job.hide = !bshow
    if @job.save
      flash[:notice] = "Publish job successful."
    else
      flash[:warning] = "Failed to save job."
    end
    redirect_to admin_jobs_path
  end

  def user_resumes
    @resumes = Resume.where(:user_id => current_user.id).all
  end

  def job_params
    params.require(:job).permit( :title, :description, :salaryMax, :salaryMin, :contact, :hide, :work_years, :work_place, :education)
  end

  def make_sure_job_right(job)
    if false == job.blank? && job.user_id != current_user.id
      flash[:alert] = "不能编辑其他公司岗位"
      redirect_to admin_jobs_path
    end
  end


end
