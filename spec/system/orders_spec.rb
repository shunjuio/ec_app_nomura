require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe '注文確認ページ' do
    let(:product) { create(:product) }
    let(:member) { create(:member) }
    let(:cart) { build(:cart) }
    let(:order) { build(:order) }

    before do
      sign_in member
      visit product_path(product)
      have_text 'カートに入れる'
      click_button 'カートに入れる'
      have_text '購入手続きへ進む'
      click_link '購入手続きへ進む'
    end

    it '商品の購入ができる' do
      have_text '注文確認'
      fill_in 'order_postal_code', with: order.postal_code
      fill_in 'order_shipping_address', with: order.shipping_address
      find('#order_payment_method_1').click
      have_text '購入確定'
      expect{ click_button '購入確定' }.to change(Order, :count).by(1).and change(OrderProduct, :count).by(1)
      expect(page).to have_current_path order_path(Order.last), ignore_query: true
      expect(page).to have_text 'ご注文完了'
      expect(page).to have_text(I18n.t('orders.create'))
    end
  end
end
