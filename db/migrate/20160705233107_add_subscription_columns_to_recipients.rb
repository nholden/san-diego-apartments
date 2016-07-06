class AddSubscriptionColumnsToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :new_unit_subscription, :string
    add_column :recipients, :rent_subscription, :string
    add_column :recipients, :availability_subscription, :string
  end
end
