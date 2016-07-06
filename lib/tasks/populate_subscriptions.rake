task :populate_subscriptions => :environment do
  Recipient.
    where(
      new_unit_subscription: nil,
      rent_subscription: nil,
      availability_subscription: nil
    ).
    update_all(
      new_unit_subscription: 'immediate',
      rent_subscription: 'immediate',
      availability_subscription: 'immediate'
    )
end
