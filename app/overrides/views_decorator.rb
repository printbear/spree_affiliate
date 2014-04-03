Deface::Override.new(
  virtual_path: "spree/admin/shared/_configuration_menu",
  name: "affiliate_admin_configurations_menu",
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
  text: "<%= configurations_sidebar_menu_item Spree.t(:affiliate_settings), spree.edit_admin_affiliate_settings_path %>"
)

Deface::Override.new(
  virtual_path: "spree/users/show",
  name: "converted_account_my_orders_69371225",
  insert_before: "[data-hook='account_my_orders'], #account_my_orders[data-hook]",
  partial: "spree/users/affiliate"
)
