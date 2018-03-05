class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items


  def total
    total_amt = 0
    self.line_items.each do |line_item|
      total_amt += (line_item.item.price * line_item.quantity)
    end
    total_amt
  end

  def add_item(item_id)
    if line_item = LineItem.find_by(item_id: item_id)
      line_item.quantity += 1
      line_item
    else
      new_line_item = LineItem.new(quantity: 1, item_id: item_id, cart_id: self.id)
    end
  end

  def checkout
    self.line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
    end
    self.update(status: "submitted")
    #binding.pry
    user.update(current_cart_id: nil)
  end

end
