require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test "get new category form and create category" do
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do #check if num of categories has increased by 1
      post categories_path, params: {category: {name: "work"}}
      follow_redirect!
    end
    assert_template 'categories/index' #redirecting you to index page
    assert_match "work", response.body #checking "work now exists"
  end

  test "invalid category submission results in failure" do #creating a scenario that should fail to test the operation
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: " "}}
    end
    assert_template 'categories/new'
    assert_select 'div.errors'
    assert_select 'li'
  end

end
