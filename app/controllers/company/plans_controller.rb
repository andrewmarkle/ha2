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
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  # after_action :verify_policy_scoped

  # GET /plans
  # GET /plans.json
  def index
    @plans = policy_scope(Plan)
    authorize @plans
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = policy_scope(Plan).new
    authorize @plan
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = policy_scope(Plan).new(plan_params)

    respond_to do |format|
      if @plan.save
        @plan.update(total_price: @plan.calculate_total_price_of_plan)
        format.html { redirect_to @plan, notice: 'Plan successfully created!' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
    authorize @plan
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan successfully updated!' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = policy_scope(Plan).find_by(id: params[:id])
      authorize @plan
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:company_id, :name, :interval, :price_per_walk, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :taxable)
    end
end
