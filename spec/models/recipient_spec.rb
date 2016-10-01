require 'rails_helper'

RSpec.describe Recipient, type: :model do
  describe "subscribed scope" do
    Given(:subscribed_recipient) { FactoryGirl.create(:recipient, unsubscribed_at: nil) }
    Given(:unsubscribed_recipient) { FactoryGirl.create(:recipient, unsubscribed_at: 1.minute.ago) }
    Then { Recipient.subscribed == [subscribed_recipient] }
  end

  describe ".subscribe_or_update" do
    context "when never subscribed" do
      Given(:recipient_params) { FactoryGirl.attributes_for(:recipient) }
      Then { expect{ Recipient.subscribe_or_update(recipient_params) }.to change{ Recipient.count }.by(1) }
    end

    context "when subscribed" do
      Given(:recipient) { FactoryGirl.create(:recipient) }
      Given(:recipient_params) { recipient.attributes }
      Given(:new_first_name) { "Bob" }
      Given { recipient_params["first_name"] = new_first_name }
      When { Recipient.subscribe_or_update(recipient_params) }
      Then { Recipient.find(recipient.id).first_name == new_first_name }
    end

    context "when unsubscribed" do
      Given(:recipient) { FactoryGirl.create(:recipient, unsubscribed_at: 1.minute.ago) }
      When { Recipient.subscribe_or_update(recipient.attributes) }
      Then { Recipient.find(recipient.id).unsubscribed_at.nil? }
    end
  end

  describe "#unsubscribe" do
    Given(:recipient) { FactoryGirl.create(:recipient, unsubscribed_at: nil) }
    When { recipient.unsubscribe }

    Then { recipient.unsubscribed_at.present? }
  end
end
