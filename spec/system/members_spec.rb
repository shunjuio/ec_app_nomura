require 'rails_helper'

RSpec.describe "Members", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "ユーザー新規登録ページ" do
    before do
      visit root_path
    end

    it "新規登録ページに遷移できる" do
      have_text "signup"
      click_link "signup"
      expect(current_path).to eq members_new_path
    end

    describe "ユーザー新規登録" do
      let(:member) { build(:member) }

      before do
        visit members_new_path
      end

      context "last_name, first_name, email, password, password_confirmationを入力した場合" do
        it "新規登録ができる" do
          have_field "Last name"
          fill_in "Last name", with: member.last_name
          fill_in "First name", with: member.first_name
          fill_in "Email", with: member.email
          fill_in "Password", with: member.password
          fill_in "Password confirmation", with: member.password_confirmation
          have_button "Sign up"
          expect { click_button "Sign up" }.to change(Member, :count).by(1)
          expect(current_path).to eq root_path
          expect(page).to have_text "ようこそhoge様"
        end
      end

      context "last_name,first_name,email, password, password_confirmationを入力しなかった場合" do
        it "新規登録ができない" do
          fill_in "Last name", with: ""
          fill_in "First name", with: ""
          fill_in "Email", with: ""
          fill_in "Password", with: ""
          fill_in "Password confirmation", with: ""
          have_button "Sign up"
          expect { click_button "Sign up" }.to change(Member, :count).by(0)
          expect(page).to have_text "4 errors prohibited this member from being saved:"
        end
      end
    end
  end
end
