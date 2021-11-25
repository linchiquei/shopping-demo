# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  quantity    :integer
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#
class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
end
