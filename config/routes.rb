ActionController::Routing::Routes.draw do |map|


  
  map.connect '*url', :controller => 'pages' , :action => 'show_page' 


end
