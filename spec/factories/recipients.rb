FactoryGirl.define do
  factory :recipient do
    first_name "Donald"
    last_name "Trump"
    email "trump@donaldjtrump.com"
    unsubscribed_at nil
    token "aLongHardToGuessSeriesOfLettersAndNumb3rs"
    new_unit_subscription "immediate"
    rent_subscription "immediate"
    availability_subscription "immediate"
  end
end
