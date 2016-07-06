class AlertMailer < ApplicationMailer
  include ActionView::Helpers::TextHelper
  default from: %("Apartment Bot" <apartmentbot@nickholden.io>)

  def alert_email(recipient, type, alerts)
    @recipient = recipient
    @type = type
    @new_unit_alerts = alerts[:new_unit_alerts]
    @rent_alerts = alerts[:rent_alerts]
    @available_alerts = alerts[:available_alerts]

    subject = "Your #{type_for_subject_line(type)} San Diego updates (#{update_counts(alerts)})"
    mail(to: recipient.email_with_name, subject: subject)
  end

  private

  def type_for_subject_line(type)
    case type
    when 'immediate' then 'recent'
    when 'daily' then 'daily'
    when 'monthly' then 'monthly'
    end
  end

  def update_counts(alerts)
    [].tap do |updated_elements|
      updated_elements.push(pluralize(alerts[:new_unit_alerts].length, "new unit")) if alerts[:new_unit_alerts].present?
      updated_elements.push(pluralize(alerts[:rent_alerts].length, "updated rent")) if alerts[:rent_alerts].present?
      updated_elements.push(pluralize(alerts[:available_alerts].length, "updated availability date")) if alerts[:available_alerts].present?
    end.join(", ")
  end
end
