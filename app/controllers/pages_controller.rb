class PagesController < ApplicationController

  def show_page
      
      url = params[:url] 
      # NOTE: urls will be case insensitve  
      url =  url.join("/")
      url.downcase!

      # NOTE : special home case 
      # NOTE : left this in the controller to show some spec'ing knowledge should_receive with etc..

      if (url == "")
          url = "home"
      end

      # NOTE could handle this differently, but I think no record returned is more in keeping with find one+of+something  methods
      
      begin
        @page = Page.find_by_url(url)
        render  
      rescue ActiveRecord::RecordNotFound
        render :file => "#{RAILS_ROOT}/public/404.html", :layout=> false, :status => 404
      end 
    
  end

end

