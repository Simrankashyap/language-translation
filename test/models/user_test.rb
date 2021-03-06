# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  username               :string
#  location               :string
#  contact                :string
#  gender                 :string
#  lang                   :string
#  tsv_data               :tsvector
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  authentication_token   :string
#  login_approval_at      :datetime
#  organization_id        :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  setup do
    @organization = create(:organization)
  end

  def teardown
    User.delete_all
    Organization.delete_all
  end

  test "should not save user without its fields username, email, first_name, last_name" do
    user = User.new
    assert_not user.save, "Saved the user without its compulsory fields"
  end

  test "should not save user without its field email" do
    user = User.new
    user.username='Alia'
    user.first_name='Aliaa'
    user.last_name='Bhatt'
    assert_not user.save, "Saved the user without its email"
  end

  test "should not save user without its field username" do
    user = User.new
    user.email='wonook@wonook.me'
    user.first_name='Aliaa'
    user.last_name='Bhatt'
    assert_not user.save, "Saved the user without its username"
  end

  test "should not save user without its field first_name" do
    user = User.new
    user.email='wonook@wonook.me'
    user.username='Alia'
    user.last_name='Bhatt'
    assert_not user.save, "Saved the user without its first_name"
  end

  test "should not save user without its field last_name" do
    user = User.new
    user.email='wonook@wonook.me'
    user.username='Alia'
    user.first_name='Aliaa'
    assert_not user.save, "Saved the user without its last_name"
  end

  test "password and its confirmation are same" do
    user = User.new
    user.organization_id=@organization.id
    user.email='wonook@wonook.me'
    user.username='Alia'
    user.first_name='Aliaa'
    user.last_name='Bhatt'
    user.password='Alia'
    user.password_confirmation='Alia'
    assert user.save, "Saved user has no authentication error"
  end

  test "password (is empty) and its confirmation are different" do
    user = User.new
    user.email='wonook@wonook.me'
    user.username='Alia'
    user.first_name='Aliaa'
    user.last_name='Bhatt'
    user.password=''
    user.password_confirmation='Alia'
    assert_not user.save, "Saved user has empty sting as password authentication error"
  end

  test "password and its confirmation are different" do
    user = User.new
    user.email='wonook@wonook.me'
    user.username='Alia'
    user.first_name='Aliaa'
    user.last_name='Bhatt'
    user.password='Not'
    user.password_confirmation='Alia'
    assert_not user.save, "Saved user has authentication error"
  end

end
