require "rails_helper" 

RSpec.describe AlertMailer, type: :mailer do
  Given(:recipient) do
    FactoryGirl.create(
      :recipient,
      new_unit_subscription:     'immediate',
      rent_subscription:         'immediate',
      availability_subscription: 'immediate',
    )
  end

  Given(:unit) { FactoryGirl.create(:unit, building: building) }
  Given(:building) { FactoryGirl.create(:building) }

  describe "subject line" do
    Given(:alerts) do
      {
        new_unit_alerts:  new_unit_alerts,
        rent_alerts:      rent_alerts,
        available_alerts: available_alerts,
      }
    end

    Given(:rent_alerts) { [FactoryGirl.create(:rent_alert, unit: unit)] }
    Given(:available_alerts) { [FactoryGirl.create(:available_alert, unit: unit)] }

    context "for immediate update" do
      Given(:type) { 'immediate' }

      context "with new units" do
        Given(:new_unit_alerts) { [FactoryGirl.create(:new_unit_alert, unit: unit), FactoryGirl.create(:new_unit_alert, unit: unit)] }
        When(:email) { AlertMailer.alert_email(recipient, type, alerts).deliver_now }
        Then { email.subject == "Your recent San Diego updates (2 new units, 1 updated rent, 1 updated availability date)" }
      end

      context "without new units" do
        Given(:new_unit_alerts) { [] }
        When(:email) { AlertMailer.alert_email(recipient, type, alerts).deliver_now }
        Then { email.subject == "Your recent San Diego updates (1 updated rent, 1 updated availability date)" }
      end
    end

    context "for daily update" do
      Given(:type) { 'daily' }

      context "with new units" do
        Given(:new_unit_alerts) { [FactoryGirl.create(:new_unit_alert, unit: unit), FactoryGirl.create(:new_unit_alert, unit: unit)] }
        When(:email) { AlertMailer.alert_email(recipient, type, alerts).deliver_now }
        Then { email.subject == "Your daily San Diego updates (2 new units, 1 updated rent, 1 updated availability date)" }
      end

      context "without new units" do
        Given(:new_unit_alerts) { [] }
        When(:email) { AlertMailer.alert_email(recipient, type, alerts).deliver_now }
        Then { email.subject == "Your daily San Diego updates (1 updated rent, 1 updated availability date)" }
      end
    end
  end
end
