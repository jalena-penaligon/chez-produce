require 'rails_helper'

RSpec.describe "admin users index", type: :feature do
  describe "as an admin user" do
    describe "when I visit user index" do
      it "shows all users who are not merchants or admins" do
        user_1 = create(:user)
        user_2 = create(:user)
        user_3 = create(:user)
        admin = create(:admin)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit root_path

        click_link "Users"

        expect(current_path).to eq(admin_users_path)

        within "#user-#{user_1.id}" do
          expect(page).to have_link(user_1.name)
          expect(page).to have_content(user_1.created_at.to_s(:long))
          expect(page).to have_button("Upgrade to Merchant")
        end

        within "#user-#{user_2.id}" do
          expect(page).to have_link(user_2.name)
          expect(page).to have_content(user_2.created_at.to_s(:long))
          expect(page).to have_button("Upgrade to Merchant")
        end

        within "#user-#{user_3.id}" do
          expect(page).to have_link(user_3.name)
          expect(page).to have_content(user_3.created_at.to_s(:long))
          expect(page).to have_button("Upgrade to Merchant")
        end

        click_link user_3.name

        expect(current_path).to eq(admin_user_path(user_3))
      end

      it "only admins can reach this path" do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit admin_users_path

        expect(page.status_code).to eq(404)
      end
    end
  end
end
