class JobsController < ApplicationController


  def index

    @q = Job.ransack(params[:q])

    # if(2 == value){
    #     myurl += "?order=by_salary_2k_5k";
    # }
    # else if(3 == value){
    #   myurl += "?order=by_salary_5k_10k";
    # }
    # else if(4 == value){
    #   myurl += "?order=by_salary_10k_20k";
    # }
    # else if(5 == value){
    #   myurl += "?order=by_salary_20k_30k";
    # }
    # else if(6 == value){
    #   myurl += "?order=by_salary_30kabove";
    # }

    @jobs = case params[:order]
        when 'by_salary_2k_5k'
          @jobs = @q.result(distinct: true).where("(salaryMin BETWEEN 2000 and 5000) OR (salaryMax < 5000 AND salaryMin >= 2000)").order(salaryMin: :DESC).page(params[:page])
        when 'by_salary_5k_10k'
          @jobs = @q.result(distinct: true).where("(salaryMin BETWEEN 5000 and 10000) OR (salaryMax < 10000 AND salaryMin >= 5000)").order(salaryMin: :DESC).page(params[:page])
        when 'by_salary_10k_20k'
          @jobs = @q.result(distinct: true).where("(salaryMin BETWEEN 10000 and 20000) OR (salaryMax < 20000 AND salaryMin >= 10000)").order(salaryMin: :DESC).page(params[:page])
        when 'by_salary_20k_30k'
          @jobs = @q.result(distinct: true).where("(salaryMin BETWEEN 20000 and 30000) OR (salaryMax < 20000 AND salaryMin >= 3000)").order(salaryMin: :DESC).page(params[:page])
        when 'by_salary_30kabove'
          @jobs = @q.result(distinct: true).where("salaryMin >= 300000").order(salaryMin: :DESC).page(params[:page])

        when 'by_default'
          @jobs = @q.result(distinct: true).order(updated_at: :DESC).page(params[:page])
        when 'by_max_salary'
          #  Job.where(hide:false).order(salaryMax: :DESC).paginate(page: params[:page])
          @jobs = @q.result(distinct: true).order(salaryMax: :DESC).page(params[:page])
        else
          # Job.where(hide:false).order(created_at: :DESC).paginate(page: params[:page])
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
    @jobs = @q.result(distinct: true).includes(:company).order(created_at: :DESC).page(params[:page])
  end

end
