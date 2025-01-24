# frozen_string_literal: true

require 'application_system_test_case'

class CrustsTest < ApplicationSystemTestCase
  setup do
    @crust = crusts(:one)
  end

  test 'visiting the index' do
    visit crusts_url
    assert_selector 'h1', text: 'Crusts'
  end

  test 'should create crust' do
    visit crusts_url
    click_on 'New crust'

    fill_in 'Name', with: @crust.name
    click_on 'Create Crust'

    assert_text 'Crust was successfully created'
    click_on 'Back'
  end

  test 'should update Crust' do
    visit crust_url(@crust)
    click_on 'Edit this crust', match: :first

    fill_in 'Name', with: @crust.name
    click_on 'Update Crust'

    assert_text 'Crust was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Crust' do
    visit crust_url(@crust)
    click_on 'Destroy this crust', match: :first

    assert_text 'Crust was successfully destroyed'
  end
end
