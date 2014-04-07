class Spree::AffiliateMailer < ActionMailer::Base
  def affiliate_email(sender, recipients, message, ref_id)
    @sender = sender
    @message = message
    @ref_id = ref_id

    name = sender.name || "Your friend"
    amount = SpreeAffiliate::Config[:recipient_credit_on_register_amount].to_i
    subject = "#{name} sent you a $#{amount} #{Spree::Config[:site_name]} credit"

    mail(to: recipients, subject: subject)
  end
end
