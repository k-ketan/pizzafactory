# frozen_string_literal: true

require 'test_helper'

class CrustTest < ActiveSupport::TestCase
  # Test that a Crust is valid with a name
  test 'should be valid with a name' do
    crust = Crust.new(name: 'Thin Crust')
    assert crust.valid?
  end

  # Test that a Crust is invalid without a name
  test 'should be invalid without a name' do
    crust = Crust.new(name: nil)
    assert_not crust.valid?, 'Crust should be invalid without a name'
    assert_includes crust.errors[:name], "can't be blank", 'Name should not be blank'
  end
end
