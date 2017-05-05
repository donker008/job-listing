class CompaniesController < ApplicationController

  before_action :authenticate_user!, only: [:index, :new, :creaate, :update]

  def index
    @company = Company.where(:user_id => current_user.id).limit(1).first
    if @company.blank?
      flash[:notice] = "请先创建公司信息"
      redirect_to new_company_path
    end
    @industries = Industry.all

    # render plain: @company.inspect

  end

  def new
    @company = Company.new
    @industries = Industry.all
  end

  def create
    @company = Company.new(company_params)
    @company.user_id = current_user.id;
    if @company.save
      flash[:notice] = "公司信息修改成功"
      redirect_to admin_jobs_path
    else
      flash[:warning] = "公司信息修改失败"
      @industries = Industry.all
      render :new
    end

  end

  def edit
      @company = Company.find(params[:id])
      @industries = Industry.all
  end

  def show
      @company = Company.find(params[:id])
      @industries = Industry.all
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      flash[:notice] = "公司信息更新成功"
      redirect_to companies_path
    else
      flash[:warning] = "公司信息更新失败"
      @industries = Industry.all
      render :new
    end

  end

  private
  def company_params
    params.require(:company).permit(:name, :description, :brand_icon,:industry)
  end
end
