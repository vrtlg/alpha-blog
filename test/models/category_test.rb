require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "work")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save #saves the category name initiated in setup so it can be used in the test
    category2 = Category.new(name:"work")
    assert_not category2.valid?
  end

  test "name shouldnt be too long" do
    @category.name = "x" * 26
    assert_not @category.valid?
  end

  test "name shouldnt be too short" do
    @category.name = "xx"
    assert_not @category.valid?
  end

end
