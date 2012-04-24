class PrefixAffiliateTablesWithSpree < ActiveRecord::Migration
  def up
    rename_table :affiliates, :spree_affiliates
    rename_table :affiliate_earnings, :spree_affiliate_earnings
    rename_table :affiliate_events, :spree_affiliate_events
    rename_table :affiliate_credits, :spree_affiliate_credits
    rename_table :affiliate_payments, :spree_affiliate_payments
  end

  def down
    rename_table :spree_affiliates, :affiliates
    rename_table :spree_affiliate_earnings, :affiliate_earnings
    rename_table :spree_affiliate_events, :affiliate_events
    rename_table :spree_affiliate_credits, :affiliate_credits
    rename_table :spree_affiliate_payments, :affiliate_payments
  end
end
