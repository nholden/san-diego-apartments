class AlertMailer < ApplicationMailer
  include ActionView::Helpers::TextHelper
  default from: %("Apartment Bot" <apartmentbot@nickholden.io>)

  def hourly_email(recipient)
    @recipient = recipient
    @new_units = NewUnitAlert.units_from_last_hour
    @rent_changed_units = RentAlert.units_from_last_hour
    @available_changed_units = AvailableAlert.units_from_last_hour

    email_with_name = %("#{@recipient.first_name} #{@recipient.last_name}" <#{@recipient.email}>)

    subject = "Your recent San Diego updates ("
    subject += "#{@new_units.length} new #{pluralize(@new_units.length, unit)}, " if @new_units.present?
    subject += "#{@rent_changed_units.length} updated #{pluralize(@rent_changed_units.length, rent)}, " if @rent_changed_units.present?
    subject += "#{@available_changed_units.length} updated available #{pluralize(@available_changed_units.length, date)}, " if @available_changed_units.present?
    subject.gsub!(/, $/, ")")

    mail(to: email_with_name, subject: subject)
  end
end
