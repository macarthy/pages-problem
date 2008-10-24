require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')



describe PagesController do 
  
  describe "route all requests to Pages#show_page" do
  
      it "should route to showpage with url tokenized" do 
       # TESTROUTES = %w{ "/a/b/c/" "/a/b/c" "a//b//c"  }
       # TESTROUTES.each  do |r|
        #  params_from(:get, "#{r}").should == { :controller => "pages", :action => "show_page", :url => ["a","b","c"] }
      #enda
      params_from(:get, "/a/b/c").should == { :controller => "pages", :action => "show_page", :url => ["a","b","c"] }
     end
  end
end


