require 'rails_helper'

RSpec.describe 'List of admins', type: :feature do
  scenario 'Admin logs in, clicks on link to view list of admins' do
    create_and_login_admin
    visit admins_dashboards_show_path

    admin_dashboard.manage_admins

    expect(page).to show :admin_list
  end

  scenario 'Admin grants an existing user admin privileges' do
    create_and_login_admin
    admin_to_be = create :user
    visit admins_dashboards_show_path

    admin_dashboard.manage_admins
    admin_manager.new_admin
    new_admin_form.email = admin_to_be.email
    new_admin_form.submit

    expect(admin_list).to include admin_to_be
    expect(flash).to have_content t('admins.admins.create.success')
  end
end