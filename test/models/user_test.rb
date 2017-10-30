require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "requires username" do
    user = User.create(username: "")
    refute user.errors[:username].empty?
  end

  test "requires email" do
    user = User.create(email: "")
    refute user.errors[:email].empty?
  end

  %w[
    a@a
    a@a.a
    invalid
    a..a@example.com
    a__a@example.com
    a.-a@example.com
    a_-a@example.com
  ].each do |email|
    test "requires valid email format (#{email})" do
      user = User.create(email: email)
      refute user.errors[:email].empty?
    end
  end

  %w[
    john@example.org
    john.doe@example.org
    john-doe@example.org
    john_doe@example.org
    john.doe.personal@example.org
    john+spam@example.org
    john+spam@sub.domain.com
    john+spam@sub-domain.com
    john@me.io
    john@example.info
  ].each do |email|
    test "accepts as valid email format (#{email})" do
      user = User.create(email: email)
      assert user.errors[:email].empty?
    end
  end

  test "rejects duplicated email" do
    user = FactoryGirl.create(:user)
    another_user = User.create(email: user.email)

    refute another_user.errors[:email].empty?
  end
end
