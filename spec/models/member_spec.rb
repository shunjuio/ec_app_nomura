require 'rails_helper'

RSpec.describe Member, type: :model do
  context "姓、名、メールアドレス、パスワードがある場合" do
    it "バリデーション有効" do
      member = Member.new(
        first_name: "sho",
        last_name: "nomu",
        email: "email@example.com",
        password: "password"
      )
      expect(member).to be_valid
    end
  end

  context "一部未入力の場合" do
    it "姓がない場合無効" do
      member = Member.new(
        first_name: "sho",
        last_name: nil,
        email: "email@example.com",
        password: "password"
      )
      expect(member).to be_invalid
    end

    it "名がない場合無効" do
      member = Member.new(
        first_name: nil,
        last_name: "nomu",
        email: "email@example.com",
        password: "password"
      )
      expect(member).to be_invalid
    end

    it "メールアドレスがない場合無効" do
      member = Member.new(
        first_name: "sho",
        last_name: "nomu",
        email: nil,
        password: "password"
      )
      expect(member).to be_invalid
    end

    it "パスワードがない場合無効" do
      member = Member.new(
        first_name: "sho",
        last_name: "nomu",
        email: "email@example.com",
        password: nil
      )
      expect(member).to be_invalid
    end
  end
end
