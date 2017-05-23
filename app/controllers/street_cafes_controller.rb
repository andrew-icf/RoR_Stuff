class StreetCafesController < ApplicationController
  def index # index action which looks for index.html.erb in street_cafes folder
    @street_cafes = StreetCafe.all
  end
end
