require 'rails_helper'

RSpec.describe "Members", type: :request do
  describe "GET /members" do
    it "新規登録画面に遷移する" do
      get new_member_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /members" do
    describe "ユーザー新規登録"  do
      let(:last_name) { "hoge" }
      let(:first_name) { "fuga" }
      let(:email) { "email@example.com" }
      let(:password) { "password" }
      let(:member_params) { { member: { last_name: last_name, first_name: first_name, email: email, password: password} } }

      before do
        post members_path, params: member_params
      end

      context "last_name,first_name,email,passwordを入力した場合" do
        it "新規登録ができる" do
          expect(response).to have_http_status(:found)
        end
      end

      context "last_nameが無い場合" do
        let(:last_name) { nil }

        it "新規登録ができない" do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "first_nameが無い場合" do
        let(:first_name) { nil }

        it "新規登録ができない" do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "emailが無い場合" do
        let(:email) { nil }

        it "新規登録ができない" do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "passwordが無い場合" do
        let(:password) { nil }

        it "新規登録ができない" do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe "ユーザーログイン" do
    let(:member) { create(:member) }
    let(:email) { member.email }
    let(:password) { member.password }
    let(:member_params) { { email: email, password: password } }

    before do
      post members_login_path, params: member_params
    end

    context "email,passwordを入力した場合" do
      it "ログインができる" do
        expect(response).to have_http_status(:found)
        expect(session[:member_id]).to eq member.id
      end
    end

    context "emailが無い場合" do
      let(:email) { nil }

      it "ログインができない" do
        expect(response).to have_http_status(:success)
        expect(flash[:danger]).to eq "Incorrect email or password"
      end
    end

    context "passwordが無い場合" do
      let(:password) { nil }

      it "ログインができない" do
        expect(response).to have_http_status(:success)
        expect(flash[:danger]).to eq "Incorrect email or password"
      end
    end

    context "email,passwordが無い場合" do
      let(:email) { nil }
      let(:password) { nil }

      it "ログインができない" do
        expect(response).to have_http_status(:success)
        expect(flash[:danger]).to eq "Incorrect email or password"
      end
    end
  end

  describe "ユーザーログアウト" do
    let(:member) { create(:member) }
    let(:email) { member.email }
    let(:password) { member.password }
    let(:member_params) { { email: email, password: password } }

    before do
      post members_login_path, params: member_params
      post members_logout_path
    end

    it "ログアウトができる" do
      expect(response).to have_http_status(:found)
      expect(session[:member_id]).to eq nil
    end
  end
end
