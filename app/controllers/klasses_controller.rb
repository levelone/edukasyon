class KlassesController < ApplicationController
  def show
    @klass = Klass.find(params[:id])
  end
end
