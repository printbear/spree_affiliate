class Spree::AffiliatesController < Spree::BaseController
  def show
    flash[:notice] = request.flash[:notice]
    redirect_to account_url
  end

  def send_email
    flash[:notice] = Spree.t('email_to_friend.mail_sent_to', email: recipient_email).html_safe
    flash[:notice] << ActionController::Base.helpers.link_to(Spree.t('email_to_friend.send_to_other'), email_to_friend_path(@object.class.name.downcase, @object)).html_safe

    sender = OpenStruct.new(name: params[:sender_name], email: params[:sender_email])
    recipients = params[:recipient_email].split(/,\s?/)
    send_message(sender, recipients, params[:message], spree_current_user.ref_id)

    recipients.each do |email|
      if Spree::Affiliate.where(affiliate_email: email).empty?
        spree_current_user.affiliates.create(affiliate_email: email)
      end
    end

    redirect_to spree.account_url
  end

  private
  def send_message(sender, recipients, message, ref_id)
    Spree::AffiliateMailer.affiliate_email(sender, recipients, message, ref_id).deliver
  end
end
