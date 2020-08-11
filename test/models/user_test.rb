require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user with valid email should be valid" do
    user = User.new(email: "test@test.org", password_digest: "testering")
    assert user.valid?
  end
  
  test "user with invalid email should not be valid" do
    user = User.new(email: "testtest.org", password_digest: "testering")
    assert_not user.valid?
  end
  
  test "user with duplicate email should not be valid" do
    other_user = users(:one)
    user = User.new(email: other_user.email, password_digest: "testering")
    assert_not user.valid?
  end
end
