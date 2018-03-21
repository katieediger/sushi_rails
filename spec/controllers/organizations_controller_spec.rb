require 'rails_helper'

RSpec.describe "Organization controller" do
  let (:sign_in) do
    visit '/'
    mock_auth_hash
    click_link "Login"
    Organization.create!(name: "test", password_digest: "test", email: "test@example.com")
  end
  describe "Organization Features", :type => :feature do
    include ApplicationHelper
    it "can create a new organization after logging in with OAuth" do
      sign_in
      visit("/organizations")
      click_link "New Organization"
      fill_in "Name", with: "test"
      fill_in "Password Digest", with: "test"
      fill_in "Email", with: "test@example.com"
      click_button('Create')
      expect(page).to have_content('test')
    end
    it "updates the user table when a user joins an organization" do
      sign_in
      visit("/organizations")
      click_link "Join"
      fill_in "Password Digest", with: "test"
      click_link "Confirm"
      visit("/user")
      expect(page).to have_content("test")
    end
    it "updates the user table when a user creates an organization" do
      sign_in
      visit("/user")
      expect(page).not_to have_content('test')
      visit("/organizations")
      click_link "New Organization"
      fill_in "Name", with: "test"
      fill_in "Password Digest", with: "test"
      fill_in "Email", with: "test@example.com"
      click_button('Create')
      expect(page).to have_content('test')
    end
    it "can join an existing organization after logging in and entering correct password" do
      #Organization.create!(name: "IIT", password_digest: "test", email: "test@example.com")
    end
    it "can not join an existing organization without the correct password" do
      #Organization.create!(name: "IIT", password_digest: "test", email: "test@example.com")
    end
    it "can edit name of an existing organization if part of that organization" do

    end
    it "can not edit name of an existing organization if not part of that organization" do

    end
    it "can not view an organization's details unless user enters the correct password" do

    end
    it "can list all users for the current organization" do

    end
    it "can recover Organization password through email" do

    end
    it "can encrypt Organization password with bcrypt" do

    end
    it "can leave Organizations successfully" do

    end
  end
end
