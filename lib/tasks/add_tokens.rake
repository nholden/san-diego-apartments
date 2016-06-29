task :add_tokens => :environment do
  Recipient.where(token: nil).each do |recipient|
    recipient.update_attributes(token: Recipient.generate_token)
  end
end
