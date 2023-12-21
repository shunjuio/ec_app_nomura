require 'rails_helper'

RSpec.describe 'Products' do
  before do
    driven_by(:rack_test)
  end

  describe '商品詳細ページ' do
    let!(:product) { create(:product) }
    let(:member) { create(:member) }
    let(:cart) { build(:cart) }

    before do
      sign_in member
      visit root_path
    end

    it '商品詳細ページが表示される' do
      click_on '響'
      expect(page).to have_current_path product_path(product), ignore_query: true
      expect(page).to have_button 'カートに入れる'
    end

    it 'カートに商品が入る' do
      visit product_path(product)
      fill_in 'quantity', with: cart.quantity
      expect { find('input[name="commit"]').click }.to change(Cart, :count).by(1)
      expect(page).to have_current_path cart_index_path, ignore_query: true
      expect(page).to have_button '購入手続きへ進む'
    end
  end
end
