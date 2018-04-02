class KlassesController < ApplicationController
  def index
    @klasses = Klass.search(params[:q])
  end

  def show
    @klass = Klass.find(params[:id])
  end
end
