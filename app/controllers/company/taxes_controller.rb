class Company::TaxesController < ApplicationController
  before_action :find_tax, only: [:show, :edit, :update]

  def show
    @tax = find_tax
    authorize @tax
  end

  def new
    @tax = policy_scope(Tax).new
    authorize @tax
  end

  def edit
    @tax = find_tax
    authorize @tax
  end

  def create
    @tax = policy_scope(Tax).new(tax_params)

    respond_to do |format|
      if @tax.save
        format.html { redirect_to @tax, notice: 'Tax was successfully created.' }
        format.json { render :show, status: :created, location: @tax }
      else
        format.html { render :new }
        format.json { render json: @tax.errors, status: :unprocessable_entity }
      end
    end
    authorize @tax
  end

  def update
    @tax = find_tax
    respond_to do |format|
      if @tax.update(tax_params)
        format.html { redirect_to @tax, notice: 'Tax was successfully updated.' }
        format.json { render :show, status: :ok, location: @tax }
      else
        format.html { render :edit }
        format.json { render json: @tax.errors, status: :unprocessable_entity }
      end
    end
    authorize @tax
  end

  private

  def find_tax
    policy_scope(Tax).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Tax not found.'
    redirect_to root_url
  end

  def tax_params
    params.require(:tax).permit(:name, :rate, :company_id)
  end
end
