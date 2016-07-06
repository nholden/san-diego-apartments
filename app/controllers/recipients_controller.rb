class RecipientsController < ApplicationController
  def create
    if recipient = Recipient.subscribe_or_update(subscribe_params)
      flash[:success] = "Subscribed #{recipient.email}."
    else
      flash[:error] = recipient.errors.full_messages.to_sentence
    end
    redirect_to root_url
  end

  def unsubscribe
    recipient = Recipient.find_by_token(params[:token])
    if recipient.try(:unsubscribe)
      flash[:success] = "Unsubscribed #{recipient.email}."
    else
      flash[:error] = "Invalid URL."
    end
    redirect_to root_url
  end

  def subscriptions
    unless @recipient = Recipient.find_by_token(params[:token])
      flash[:error] = "Invalid URL."
      redirect_to root_url
    end
  end

  def update
    if recipient = Recipient.find_by_token(subscription_params[:token])
      recipient.update_attributes(subscription_params)
      flash[:success] = "Updated subscriptions for #{recipient.email}."
    else
      flash[:error] = "Invalid URL."
    end
    redirect_to root_url
  end

  private

  def subscribe_params
    params.require(:recipient).permit(:first_name, :last_name, :email)
  end

  def subscription_params
    params.require(:recipient).permit(:new_unit_subscription, :rent_subscription, :availability_subscription, :token)
  end
end
