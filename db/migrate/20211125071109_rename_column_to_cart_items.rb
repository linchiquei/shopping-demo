class RenameColumnToCartItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :cart_items, :quanitiy, :quantity
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
