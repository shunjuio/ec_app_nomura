require 'rails_helper'

RSpec.describe 'Members', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'ユーザー新規登録ページ' do
    before do
      visit root_path
    end

    it '新規登録ページに遷移できる' do
      have_text 'signup'
      click_link 'signup'
      expect(page).to have_current_path members_new_path, ignore_query: true
    end

    describe 'ユーザー新規登録' do
      let(:member) { build(:member) }

      before do
        visit members_new_path
        @i18n_scope = 'activerecord.errors.models.member.attributes'
      end

      context 'last_name, first_name, email, password, password_confirmationを入力した場合' do
        it '新規登録ができる' do
          have_field 'Last name'
          fill_in 'Last name', with: member.last_name
          fill_in 'First name', with: member.first_name
          fill_in 'Email', with: member.email
          fill_in 'Password', with: member.password
          fill_in 'Password confirmation', with: member.password_confirmation
          have_button 'Sign up'
          expect { click_button 'Sign up' }.to change(Member, :count).by(1)
          expect(page).to have_current_path root_path, ignore_query: true
          expect(page).to have_text 'ようこそhoge様'
        end
      end

      context 'last_name,first_name,email, password, password_confirmationを入力しなかった場合' do
        it '新規登録ができない' do
          fill_in 'Last name', with: ''
          fill_in 'First name', with: ''
          fill_in 'Email', with: ''
          fill_in 'Password', with: ''
          fill_in 'Password confirmation', with: ''
          have_button 'Sign up'
          expect { click_button 'Sign up' }.to change(Member, :count).by(0)
          expect(page).to have_current_path member_registration_path, ignore_query: true
          expect(page).to have_text(I18n.t("#{@i18n_scope}.email.blank"))
          expect(page).to have_text(I18n.t("#{@i18n_scope}.password.blank"))
          expect(page).to have_text(I18n.t("#{@i18n_scope}.first_name.blank"))
          expect(page).to have_text(I18n.t("#{@i18n_scope}.last_name.blank"))
        end
      end
    end
  end

  describe 'ユーザーログインページ' do
    let(:member) { create(:member) }

    before do
      visit root_path
      @i18n_scope = 'devise.failure'
    end

    it 'ログインページに遷移できる' do
      have_text 'login'
      click_link 'login'
      expect(page).to have_current_path members_login_path, ignore_query: true
    end

    describe 'ユーザーログイン' do
      before do
        visit members_login_path
      end

      context 'email,passwordを正しく入力した場合'  do
        it 'ログインができる' do
          have_field 'Email'
          fill_in 'Email', with: member.email
          fill_in 'Password', with: member.password
          have_button 'Log in'
          click_button 'Log in'
          expect{ member.reload }.to change(member, :sign_in_count).by(1)
          expect(page).to have_current_path root_path, ignore_query: true
          expect(page).to have_text 'ようこそhoge様'
        end
      end

      context 'emailを間違えた場合' do
        it 'ログインができない' do
          fill_in 'Email', with: 'wrong_email'
          fill_in 'Password', with: member.password
          have_button 'Log in'
          click_button 'Log in'
          expect{ member.reload }.to change(member, :sign_in_count).by(0)
          expect(page).to have_current_path new_member_session_path, ignore_query: true
          expect(page).to have_text(I18n.t("#{@i18n_scope}.not_found_in_database", authentication_keys: 'Email'))
        end
      end

      context 'passwordを間違えた場合' do
        it 'ログインができない' do
          fill_in 'Email', with: member.email
          fill_in 'Password', with: 'wrong_password'
          have_button 'Log in'
          click_button 'Log in'
          expect{ member.reload }.to change(member, :sign_in_count).by(0)
          expect(page).to have_current_path new_member_session_path, ignore_query: true
          expect(page).to have_text(I18n.t("#{@i18n_scope}.invalid", authentication_keys: 'Email'))
        end
      end

      context 'email,passwordを入力しなかった場合' do
        it 'ログインができない' do
          fill_in 'Email', with: ''
          fill_in 'Password', with: ''
          have_button 'Log in'
          click_button 'Log in'
          expect{ member.reload }.to change(member, :sign_in_count).by(0)
          expect(page).to have_current_path new_member_session_path, ignore_query: true
          expect(page).to have_text(I18n.t("#{@i18n_scope}.invalid", authentication_keys: 'Email'))
        end
      end
    end
  end

  describe 'ユーザーログアウト' do
    let(:member) { create(:member) }

    before do
      sign_in member
      visit root_path
    end

    it 'ログアウトができる' do
      have_text 'logout'
      click_link 'logout'
      expect(page).to have_current_path root_path, ignore_query: true
      expect(page).to have_text 'login'
      expect(page).to have_no_text 'ようこそhoge様'
    end
  end

  describe 'ユーザー編集ページ' do
    let(:member) { create(:member) }
    let(:last_name) { 'fuga2' }
    let(:first_name) { 'hoge2' }
    let(:email) { 'email2@example.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }
    let(:current_password) { 'password' }

    before do
      sign_in member
      visit root_path
    end

    it '編集ページに遷移できる' do
      have_text 'mypage'
      click_link 'mypage'
      expect(page).to have_current_path edit_member_registration_path, ignore_query: true
    end

    describe 'ユーザー編集' do
      before do
        visit edit_member_registration_path
        @i18n_scope = 'activerecord.errors.models.member.attributes'
      end

      it 'フォームにcurrent_memberの情報が入っている' do
        have_text 'Edit Member'
        expect(find('#member_last_name').value).to eq member.last_name
        expect(find('#member_first_name').value).to eq member.first_name
        expect(find('#member_email').value).to eq member.email
      end

      context 'last_name, first_name, email,passwordを正しく入力した場合' do
        it '編集ができる' do
          fill_in 'Last name', with: last_name
          fill_in 'First name', with: first_name
          fill_in 'Email', with: email
          fill_in 'Password', with: password
          fill_in 'Password confirmation', with: password_confirmation
          fill_in 'Current password', with: current_password
          have_button 'Update'
          click_button 'Update'
          expect {member.reload}.to change(member, :last_name).from(member.last_name).to(last_name)
                               .and change(member, :first_name).from(member.first_name).to(first_name)
                               .and change(member, :email).from(member.email).to(email)
          expect(page).to have_current_path root_path, ignore_query: true
        end
      end

      context 'last_name, first_name, email,passwordを入力しなかった場合' do
        it '編集ができない' do
          fill_in 'Last name', with: ''
          fill_in 'First name', with: ''
          fill_in 'Email', with: ''
          fill_in 'Password', with: ''
          fill_in 'Password confirmation', with: ''
          fill_in 'Current password', with: ''
          have_button 'Update'
          click_button 'Update'
          expect(page).to have_current_path member_registration_path, ignore_query: true
          expect(page).to have_text(I18n.t("#{@i18n_scope}.email.blank"))
          expect(page).to have_text(I18n.t("#{@i18n_scope}.password.blank"))
          expect(page).to have_text(I18n.t("#{@i18n_scope}.first_name.blank"))
          expect(page).to have_text(I18n.t("#{@i18n_scope}.last_name.blank"))
          expect(page).to have_text(I18n.t("#{@i18n_scope}.current_password.blank"))
        end
      end
    end
  end
end
