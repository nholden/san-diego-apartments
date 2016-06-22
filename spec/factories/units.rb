FactoryGirl.define do
  factory :unit do
    name "121"
    beds 1
    building_id 1
    square_feet 500
    rent 2000
    available Date.new(2016, 8, 15)
    lease_months 12
  end
end
