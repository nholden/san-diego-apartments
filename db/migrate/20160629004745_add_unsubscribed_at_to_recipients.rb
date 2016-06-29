class AddUnsubscribedAtToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :unsubscribed_at, :datetime
  end
end
