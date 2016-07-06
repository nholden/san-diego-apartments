class AlertMailerPreview < ActionMailer::Preview
  def hourly
    AlertMailer.alert_email(Recipient.last)
  end
end
