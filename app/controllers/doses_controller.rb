class DosesController < ApplicationController
  before_action :set_cocktail, except: [:destroy]
  def new
    @doses = @cocktail.doses
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to new_cocktail_dose_path
    else
      render 'doses/new'
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to new_cocktail_dose_path(@dose.cocktail)
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
