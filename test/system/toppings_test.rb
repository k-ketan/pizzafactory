# frozen_string_literal: true

require 'application_system_test_case'

class ToppingsTest < ApplicationSystemTestCase
  setup do
    @topping = toppings(:one)
  end

  test 'visiting the index' do
    visit toppings_url
    assert_selector 'h1', text: 'Toppings'
  end

  test 'should create topping' do
    visit toppings_url
    click_on 'New topping'

    fill_in 'Category', with: @topping.category
    fill_in 'Name', with: @topping.name
    fill_in 'Price', with: @topping.price
    click_on 'Create Topping'

    assert_text 'Topping was successfully created'
    click_on 'Back'
  end

  test 'should update Topping' do
    visit topping_url(@topping)
    click_on 'Edit this topping', match: :first

    fill_in 'Category', with: @topping.category
    fill_in 'Name', with: @topping.name
    fill_in 'Price', with: @topping.price
    click_on 'Update Topping'

    assert_text 'Topping was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Topping' do
    visit topping_url(@topping)
    click_on 'Destroy this topping', match: :first

    assert_text 'Topping was successfully destroyed'
  end
end
