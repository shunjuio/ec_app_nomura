class HomeController < ApplicationController
  def top
    @products = Product.all
    @member = Member.find_by(id: current_member.id)
  end
end
