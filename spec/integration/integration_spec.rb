require 'rails_helper'

RSpec.describe 'Visit home page', type: :feature do
  scenario 'sign up user' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Name', with: 'example'
    fill_in 'Email', with: 'Example-1@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click
    assert_text 'Welcome! You have signed up successfully.'
  end
end

RSpec.describe 'Visit home page', type: :feature do
  scenario 'not allow to duplicate users on sign up' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Name', with: 'example'
    fill_in 'Email', with: 'Example-1@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click
    assert_text 'Welcome! You have signed up successfully.'
    click_on 'Sign out'
    click_on 'Sign up'
    fill_in 'Name', with: 'example'
    fill_in 'Email', with: 'Example-1@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click
    assert_text 'Email has already been taken'
  end
end

RSpec.describe 'Visit home page', type: :feature do
  scenario 'log in user' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Name', with: 'example'
    fill_in 'Email', with: 'Example-1@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click
    click_on 'Sign out'

    fill_in 'Email', with: 'Example-1@example.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
    assert_text 'Signed in successfully.'
  end
end

RSpec.describe Friendship, type: :feature do
  scenario 'Send friend request' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'jdoe@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click
    click_on 'Sign out'

    click_on 'Sign up'
    fill_in 'Name', with: 'Example'
    fill_in 'Email', with: 'Example-1@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click
    click_on 'Sign out'

    fill_in 'Email', with: 'Example-1@example.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
    assert_text 'Signed in successfully.'
    visit users_path
    click_on 'Add friend'
    assert_text 'Friendship request sent!'
    click_on 'Sign out'

    fill_in 'Email', with: 'jdoe@example.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
    assert_text 'Signed in successfully.'
    visit friendships_path
    click_on 'Accept request'
  end
end

RSpec.describe Friendship, type: :feature do
  scenario 'Destroy friendship' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'jdoe@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click
    click_on 'Sign out'

    click_on 'Sign up'
    fill_in 'Name', with: 'Example'
    fill_in 'Email', with: 'Example-1@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click
    click_on 'Sign out'

    fill_in 'Email', with: 'Example-1@example.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
    assert_text 'Signed in successfully.'
    visit users_path
    click_on 'Add friend'
    assert_text 'Friendship request sent!'
    click_on 'Sign out'

    fill_in 'Email', with: 'jdoe@example.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
    assert_text 'Signed in successfully.'
    visit friendships_path
    click_on 'Accept request'
    visit users_path
    click_on 'Remove'
    assert_text 'Friendship has been deleted'
  end
end
