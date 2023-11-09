require 'rails_helper'

RSpec.describe "Products", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "商品詳細ページ" do
    let!(:product) { create(:product) }
    let(:member) { create(:member) }
    let(:cart) { build(:cart) }

    before do
      sign_in member
      visit root_path
    end

    it "商品詳細ページが表示される" do
      click_link "響"
      expect(current_path).to eq product_path(product)
      expect(page).to have_button "カートに入れる"
    end

    it "カートに商品が入る" do
      visit product_path(product)
      fill_in "quantity", with: cart.quantity
      expect{ find('input[name="commit"]').click }.to change { Cart.count }.by(1)
      expect(current_path).to eq cart_index_path
      expect(page).to have_button "購入手続きへ進む"
    end
  end
end
