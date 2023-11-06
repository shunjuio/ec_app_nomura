require 'rails_helper'

RSpec.describe "Members", type: :request do
  describe "GET /members" do
    it "ステータス200が返ってくる" do
      get new_member_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /members" do
    let(:member_params) do
      { member: {
        last_name: "nomu",
        first_name: "sho",
        email: "email@example.com",
        password: "password"
        }
      }
    end
    context "バリデーションが有効な場合" do
      it "新規登録ができる" do
        post members_path, params: member_params
        expect(response).to have_http_status(:found)
      end
    end

    context "バリデーションが無効な場合" do
      it "姓が無い場合" do
        post members_path, params: member_params.merge(member: { last_name: nil })
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "名が無い場合" do
        post members_path, params: member_params.merge(member: { first_name: nil })
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "emailが無い場合" do
        post members_path, params: member_params.merge(member: { email: nil })
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passwordが無い場合" do
        post members_path, params: member_params.merge(member: { password: nil })
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
