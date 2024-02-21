class CheckoutController < ApplicationController
    def create
      @amount = 500

      customer = Stripe::Customer.create(
      
      :email => params[:stripeEmail],
      
      :source => params[:stripeToken]
      
      )
      
      charge = Stripe::Charge.create(
      
      :customer => customer.id,
      
      :amount => @amount,
      
      :description => Rails Stripe customer,
      
      :currency => usd
      
      )
      
      rescue Stripe::CardError => e
      
      flash[:error] = e.message
      
      redirect_to new_attendance_path
      
      
      end
    
      def success
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
        @event_id = @session.metadata.event_id
      end
    
      def cancel
      end



end
