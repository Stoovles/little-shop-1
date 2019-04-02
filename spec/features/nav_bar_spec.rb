require 'rails_helper'

RSpec.describe 'When I visit our application I see a navbar' do
  #User Story 2
  describe 'As an unregistered user I see' do
    it 'has links to features available to unregistered users' do
      visit "/"
      within(".navbar") do
        expect(page).to have_link 'Home'
        click_link 'Home'
        expect(current_path).to eq(root_path)
        expect(page).to have_link 'All Items'
        click_link 'All Items'
        expect(current_path).to eq(items_path)
        # expect(page).to have_link 'Merchants', merchants_path
        # click_link 'Merchants'
        # expect(current_path).to eq(merchants_path)
        # expect(page).to have_link 'My Cart', cart_path(my_cart)
        # click_link 'My Cart'
        # expect(current_path).to eq(my_cart_path)
        # expect(page).to have_link 'Log In', login_path
        # click_link 'Log In'
        # expect(current_path).to eq(login_path)
        # expect(page).to have_link 'Register', new_user_path
        # click_link 'Register'
        # expect(current_path).to eq(new_user_path)
      end
    end

    xit 'displays number of items in cart' do
      visit "/"
      #check within navbar for "0"
      visit "/items"
      #add item to cart
      #check navbar for content "1"
    end
  end

#   #User Story 3
#   describe 'As a registered user I see' do
#     @user = User.create(first_name: 'Matt', last_name: 'Weiss')
#     # login user here
#     within(".navbar") do
#       xit 'has all the above links except login and register' do
#         expect(page).to have_link 'Home Page' #root_path
#         expect(page).to have_link 'All Items', items_path
#         expect(page).to have_link 'Merchants', merchants_path
#         expect(page).to have_link 'My Cart', cart_path(my_cart)
#         expect(page).to_not have_link 'Log In' #login_path
#         expect(page).to_not have_link 'Register' #register_path
#       end
#
#       xit 'displays the user name' do
#         expect(page).to have_content 'Welcome Back, Matt'
#       end
#
#       xit 'also has logout and profile links' do
#         expect(page).to have_link 'Log Out' #logout_path
#         expect(page).to have_link 'Profile', user_path(@user)
#       end
#     end
#   end
#
#   #User Story 4
#   describe 'As a merchant user I see' do
#     @merchant = User.create(first_name: 'Matt', last_name: 'Weiss')
#     #assign merchant status here (or in params above)
#     #login user here
#     within(".navbar") do
#       xit 'has all the above links except login and register or shopping cart' do
#         expect(page).to have_link 'Home Page' #root_path
#         expect(page).to have_link 'All Items', items_path
#         expect(page).to have_link 'Merchants', merchants_path
#         expect(page).to_not have_link 'My Cart', cart_path(my_cart)
#         expect(page).to_not have_link 'Log In' #login_path
#         expect(page).to_not have_link 'Register' #register_path
#       end
#
#       xit 'also has logout and dashboard links' do
#         expect(page).to have_link 'Log Out' #logout_path
#         expect(page).to have_link 'Dashboard', merchant_path(@merchant) #'/dashboard'
#       end
#     end
#   end
#
#   #User Story 5
#   describe 'As an admin I see' do
#     @admin = User.create(first_name: 'Matt', last_name: 'Weiss')
#     #assign admin status here (or in params above)
#     #login user here
#     within(".navbar") do
#       xit 'has all the above links except login and register or shopping cart' do
#         expect(page).to have_link 'Home Page' #root_path
#         expect(page).to have_link 'All Items', items_path
#         expect(page).to have_link 'Merchants', merchants_path
#         expect(page).to_not have_link 'My Cart', cart_path(my_cart)
#         expect(page).to_not have_link 'Log In' #login_path
#         expect(page).to_not have_link 'Register' #register_path
#       end
#
#       xit 'also has logout and dashboard links' do
#         expect(page).to have_link 'Log Out' #logout_path
#         expect(page).to have_link 'Dashboard', admin_path(@admin) #'/dashboard'
#       end
#     end
#   end
end
