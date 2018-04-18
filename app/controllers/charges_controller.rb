class ChargesController < ApplicationController
  def new
  end

  def create
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken])

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => 500, #in cents
      :description => 'Rails Stripe Customer',
      :currency => 'aud'
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end

end
