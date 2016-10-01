class AlertPreview < ActionMailer::Preview
  def hourly
    AlertMailer.hourly_email(Recipient.last)
  end
end
