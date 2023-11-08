require 'rails_helper'

RSpec.describe "Products", type: :system do

  before do
    driven_by(:rack_test)
  end

  describe "商品詳細ページ" do
    let(:product) { create(:product) }

    it "商品詳細ページが表示される" do
      visit product_path(product)
      expect(page).to have_button "カートに入れる"
    end
  end

  describe "カートに商品を入れる" do
    let(:product) { create(:product) }
    let(:member) { create(:member) }
    let(:email) { member.email }
    let(:password) { member.password }
    let(:cart) { build(:cart) }

    before do
      sign_in member
    end

    it "カートに商品が入る" do
      visit product_path(product)
      expect(page).to have_selector("#product_id", visible: false)
      expect(page).to have_selector("#member_id", visible: false)

      fill_in "quantity", with: cart.quantity
      expect{ find('input[name="commit"]').click }.to change { Cart.count }.by(1)
      expect(current_path).to eq cart_index_path
      expect(page).to have_button "購入手続きへ進む"
    end
  end
end
