require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe "unique name validation" do
    Given(:name) { "1301" }

    context "when a building with that name exists" do
      Given { FactoryGirl.create(:unit, name: name) }
      Then { Unit.new(name: name).valid? == false }
    end

    context "when a building with that name doesn't exist" do
      Then { Unit.new(name: name).valid? == true }
    end
  end
end
