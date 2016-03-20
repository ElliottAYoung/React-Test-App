class HomeController < ApplicationController
  def index
    p "Polling"
    @records = Record.all
  end
end
