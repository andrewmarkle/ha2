# == Schema Information
#
# Table name: plans
#
#  id             :uuid             not null, primary key
#  company_id     :uuid             indexed
#  name           :string
#  interval       :integer
#  monday         :boolean          default(FALSE), not null
#  tuesday        :boolean          default(FALSE), not null
#  wednesday      :boolean          default(FALSE), not null
#  thursday       :boolean          default(FALSE), not null
#  friday         :boolean          default(FALSE), not null
#  saturday       :boolean          default(FALSE), not null
#  sunday         :boolean          default(FALSE), not null
#  taxable        :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  total_price    :integer
#  price_per_walk :integer
#

class Company::PlansController < ApplicationController
  before_action :find_plan, only: [:show, :edit, :update, :destroy]

  def index
    @plans = policy_scope(Plan)
    authorize @plans
  end

  def show
    @plan = find_plan
    authorize @plan
  end

  def new
    @plan = policy_scope(Plan).new
    authorize @plan
  end

  def edit
    @plan = find_plan
    authorize @plan
  end

  def create
    @plan = policy_scope(Plan).new(plan_params)

    respond_to do |format|
      if @plan.save
        @plan.calculate_total_price
        format.html { redirect_to @plan, notice: 'Plan successfully created!' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
    authorize @plan
  end

  def update
    @plan = find_plan
    respond_to do |format|
      if @plan.update(plan_params)
        @plan.calculate_total_price
        format.html { redirect_to @plan, notice: 'Plan successfully updated!' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
    authorize @plan
  end

  def destroy
    @plan = find_plan
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan successfully destroyed.' }
      format.json { head :no_content }
    end
    authorize @plan
  end

  private

  def find_plan
    policy_scope(Plan).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Plan not found.'
    redirect_to root_url
  end

  def plan_params
    params.require(:plan).permit(:company_id, :name, :interval, :price_per_walk, :virtual_dollars, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :taxable)
  end
end
