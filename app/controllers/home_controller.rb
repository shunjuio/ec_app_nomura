class HomeController < ApplicationController
  def top
    @products = Product.all
    @member = Member.find_by(id: session[:member_id]) unless session[:member_id].nil?
  end
end
