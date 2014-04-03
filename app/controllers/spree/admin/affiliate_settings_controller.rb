module Spree
  module Admin
    class AffiliateSettingsController < BaseController
      def update
        SpreeAffiliate::Config.set(params[:preferences])
        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:affiliate_settings))
        redirect_to spree.edit_admin_affiliate_settings_path
      end
    end
  end
end

