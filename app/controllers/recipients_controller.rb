class RecipientsController < ApplicationController
  def create
    if recipient = Recipient.subscribe_or_update(recipient_params)
      flash[:success] = "You have been successfully subscribed to updates."
    else
      flash[:error] = recipient.errors.full_messages.to_sentence
    end
    redirect_to root_url
  end

  def unsubscribe
    recipient = Recipient.find_by_token(params[:token])
    if recipient.try(:unsubscribe)
      flash[:success] = "#{recipient.email} has successfully been unsubscribed from updates."
    else
      flash[:error] = "Invalid URL."
    end
    redirect_to root_url
  end

  private

  def recipient_params
    params.require(:recipient).permit(:first_name, :last_name, :email)
  end
end
