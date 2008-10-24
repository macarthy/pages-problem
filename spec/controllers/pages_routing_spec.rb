require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do 
 
      

  
  describe "route all requests to Pages#show_page" do
    # NOTE: double slashes will give a empty array element - behaviour should be decided
    # NOTE: query strings will also be passed with the ast array element - show page be shown
    
    it "should route to showpage with url = array of path  token" do 
          params_from(:get,"/aaaa/bbbb/ccccc?x=y").should == { :controller => "pages", :action => "show_page", :url => ["aaaa","bbbb","ccccc?x=y"]}
          params_from(:get,"/a/b/c").should == { :controller => "pages", :action => "show_page", :url => ["a","b","c"]}
    end
  end


  describe "if a page is not found a 404 should be served , without a redirect" do 

     before do

       @page = mock_model(Page)
       Page.stub!(:find_by_url).with("a_bad_url").and_raise(ActiveRecord::RecordNotFound)
       Page.stub!(:find_by_url).with("a_good_url").and_return(@page)
       Page.stub!(:find_by_url).with("home").and_return(@page)                    
                         
     end
   
    def getpage(str)
         route  =  params_from(:get,"#{str}")
        get route[:action], :url => route[:url]
     end


    it "should display 404 for bad urls" do   
         getpage("/a_bad_url")
         response.should render_template("#{RAILS_ROOT}/public/404.html")
         response.response_code.should == 404 
    end 
  
    it "should diplay the show_page template for a good url" do
        getpage("/a_good_url")
        response.should render_template(:show_page)
        response.response_code.should == 200 
    end

    it "should treat / as special and call find_by_url(home)" do
      getpage("/")
      Page.should_receive(:find_by_url).with("home").once
      response.should render_template(:show_page)
      response.response_code.should == 200 
    

    end
    
    it "should treat empty path  as special and call find_by_url(home)" do
      getpage("")
      Page.should_receive(:find_by_url).with("home").once
      response.should render_template(:show_page)
      response.response_code.should == 200 
    end





  end

end 
