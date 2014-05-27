Spree::UserRegistrationsController.class_eval do
  include AffiliateCredits

  after_filter :check_affiliate, only: :create

  private
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
