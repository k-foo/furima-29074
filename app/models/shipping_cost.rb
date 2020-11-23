class ShippingCost < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '着払い（購入者負担）' },
    { id: 2, name: '送料払い（出品者負担）' }
  ]

  include ActiveHash::Associations
  has_many :items
end
