module AffiliateCredits
  private
  def create_affiliate_credits(sender, recipient, event)
    # Check if sender should receive credit on affiliate register
    if (sender_credit_amount = SpreeAffiliate::Config["sender_credit_on_#{event}_amount".to_sym]) && sender_credit_amount.to_f > 0
      credit = Spree::StoreCredit.create(
        amount: sender_credit_amount,
        remaining_amount: sender_credit_amount,
        reason: "Affiliate: #{event}",
        user_id: sender.id
      )

      log_event recipient.affiliate_partner, sender, credit, event
    end

    # Check if affiliate should recevie credit on sign up
    if (recipient_credit_amount = SpreeAffiliate::Config["recipient_credit_on_#{event}_amount".to_sym]) && recipient_credit_amount.to_f > 0
      credit = Spree::StoreCredit.create(
        amount: recipient_credit_amount,
        remaining_amount: recipient_credit_amount,
        reason: "Affiliate: #{event}",
        user_id: recipient.id
      )

      log_event recipient.affiliate_partner, recipient, credit, event
    end
  end

  def log_event(affiliate, user, credit, event)
    affiliate.events.create(reward: credit, name: event, user: user)
  end

  def check_affiliate
    return if cookies[:ref_id].blank? || @user.invalid?

    if sender = Spree::User.find_by_ref_id(cookies[:ref_id])
      affiliate = sender.affiliates.where(affiliate_email: @user.email).first

      if affiliate.nil? && Spree::Affiliate.where(affiliate_email: @user.email).empty?
        affiliate = sender.affiliates.create(affiliate_email: @user.email)
      end

      if affiliate && affiliate.user.nil?
        affiliate.update_attribute(:user_id, @user.id)
      end

      create_affiliate_credits(sender, @user, "register") if @user.affiliate_partner
    end

    cookies[:ref_id] = nil
  end
end
