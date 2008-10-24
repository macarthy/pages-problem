require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
  
  Page.find(:all).each { |p| p.save }    

  end
  
  def test_truth
    assert true
  end


 def test_should_find_home_page
    
    assert_equal(Page.find_by_url("home"), pages(:home),"home expected")

 end 


 def test_page_should_recieve_find_by_url


   assert_respond_to(Page, :find_by_url,"find_by_url should succeed")   
 
 end


 def test_page_throws_a_AR_not_found_for_a_bogus_url
 
  assert_raise(ActiveRecord::RecordNotFound,"SHould find no record") do 
   Page.find_by_url("some/rubish") 
  end
 
 end

 def test_page_is_returned_by_find_by_url
  
   assert_kind_of Page, Page.find_by_url("home")

 end


 def test_the_correct_records_are_returned_for_fixtures
   
    assert_equal(Page.find_by_url("home"), pages(:home),"home expected")
    assert_equal(Page.find_by_url("products"), pages(:products),"products expected")
    assert_equal(Page.find_by_url("services"), pages(:services))
    assert_equal(Page.find_by_url("products/alpha"), pages(:product_alpha))
    assert_equal(Page.find_by_url("products/alpha/further_info"),pages(:further_information))
    assert_equal(Page.find_by_url("products/beta"), pages(:product_beta))
    assert_equal(Page.find_by_url("products/beta/further_info"), pages(:further_information_beta))
 
  end


  def test_that_renaming_update_child_path_cache
    @page = Page.find_by_url("products")
    @page.url_title = "oldproducts"
    @page.save
    assert_equal(Page.find_by_url("oldproducts/beta/further_info"), pages(:further_information_beta))
  end

end
