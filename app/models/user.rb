class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts
  belongs_to :current_cart, class_name: "Cart", foreign_key: "current_cart_id"

  def new_cart
    new_cart = self.carts.create
    new_cart.user = self
    self.current_cart = new_cart
    self.save
    #binding.pry
  end
end
