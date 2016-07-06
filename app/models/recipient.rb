class Recipient < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :token, { presence: true, uniqueness: true }
  validates :email, { presence: true, uniqueness: true, email: true }

  scope :subscribed, -> { where("unsubscribed_at IS NULL") }

  def self.subscribe_or_update(recipient_params)
    if recipient = Recipient.find_by_email(recipient_params["email"])
      recipient.update_attributes(recipient_params)
      recipient.unsubscribed_at = nil
    else
      recipient = Recipient.new(recipient_params)
      recipient.token = generate_token
    end
    recipient.save
  end

  def self.generate_token
    token = Digest::SHA1.hexdigest([Time.now, rand].join)
    generate_token if token.in?(Recipient.pluck(:token))
    token
  end

  def unsubscribe
    self.unsubscribed_at = DateTime.now
    save
  end

  def email_with_name
    "\"#{first_name} #{last_name}\" <#{email}>"
  end
end
