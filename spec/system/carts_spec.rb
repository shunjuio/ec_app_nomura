require 'rails_helper'

RSpec.describe 'Carts', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'カートページ' do
    let(:product) { create(:product) }
    let(:member) { create(:member) }
    let(:cart) { build(:cart) }

    before do
      sign_in member
      visit product_path(product)
      fill_in 'quantity', with: cart.quantity
      have_text 'カートに入れる'
      click_button 'カートに入れる'
    end

    it 'カートの中身が削除できる' do
      have_text '削除'
      expect{ click_link '削除' }.to change { Cart.count }.by(-1)
      expect(current_path).to eq cart_index_path
      expect(page).to have_no_text '削除'
    end

    it '注文確認画面に進める' do
      have_text '購入手続きへ進む'
      click_link '購入手続きへ進む'
      expect(current_path).to eq new_order_path
      expect(page).to have_text '注文確認'
    end
  end
end