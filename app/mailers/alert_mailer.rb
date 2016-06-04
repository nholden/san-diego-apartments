class AlertMailer < ApplicationMailer
  default from: "apartmentbot@nickholden.io"

  def hourly_email(recipient)
    @recipient = recipient
    @new_units = NewUnitAlert.units_from_last_hour
    @rent_changed_units = RentAlert.units_from_last_hour
    @available_changed_units = AvailableAlert.units_from_last_hour

    mail(to: @recipient.email, subject: "Your recent San Diego apartment updates")
  end
end
