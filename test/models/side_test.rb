# frozen_string_literal: true

require 'test_helper'

class SideTest < ActiveSupport::TestCase
  def setup
    @side = sides(:one)
  end

  test 'should be valid with valid attributes' do
    assert @side.valid?, 'Side should be valid with a name and price'
  end

  test 'should not be valid without a name' do
    @side.name = nil
    assert_not @side.valid?, 'Side is valid without a name'
    assert_includes @side.errors[:name], "can't be blank"
  end

  test 'should not be valid without a price' do
    @side.price = nil
    assert_not @side.valid?, 'Side is valid without a price'
    assert_includes @side.errors[:price], "can't be blank"
  end
end
