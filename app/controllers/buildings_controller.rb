class BuildingsController < ApplicationController
  def index
    @buildings = Building.all
    @recipient = Recipient.new
  end
end
