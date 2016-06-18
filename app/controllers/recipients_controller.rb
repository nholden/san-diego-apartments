class RecipientsController < ApplicationController
  def create
    @recipient = Recipient.new(recipient_params)
    if @recipient.save
      flash[:success] = "You have been successfully subscribed to updates."
    else
      flash[:error] = @recipient.errors.full_messages.to_sentence
    end
    redirect_to root_url
  end

  private

  def recipient_params
    params.require(:recipient).permit(:first_name, :last_name, :email)
  end
end
