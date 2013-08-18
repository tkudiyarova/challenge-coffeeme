class DrinksController < ApplicationController 
  def index
  	@drinks = Drink.all
  end

  def new
  	@drink = Drink.new
  end
end
