Spree::UsersController.class_eval do
  include AffiliateCredits

  after_filter :check_affiliate, only: :new_user_account
end
