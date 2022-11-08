require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test 'Going to /new gives us a new random grid to play with' do
    visit new_url
    assert_selector 'div.card-letter', count: 10
  end

  test 'Submitting random word yields message that word is not in grid' do
    visit new_url
    fill_in 'word', with: 'iamrandomhehe'
    click_on 'Play'

    assert_text 'cannot be built out of'
  end

  test 'Submitting no word yields message that word is required' do
    visit new_url
    fill_in 'word', with: ''
    click_on 'Play'

    assert_text 'You need to enter a word!'
  end
end
