class AddTokenToRecipient < ActiveRecord::Migration
  def change
    add_column :recipients, :token, :string
  end
end
