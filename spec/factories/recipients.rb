FactoryGirl.define do
  factory :recipient do
    first_name "Donald"
    last_name "Trump"
    email "trump@donaldjtrump.com"
    unsubscribed_at nil
    token "aLongHardToGuessSeriesOfLettersAndNumb3rs"
  end
end
