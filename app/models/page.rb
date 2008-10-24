class Page < ActiveRecord::Base

  USE_PATH_CACHE = true 
  

  acts_as_nested_set :parent_column => "parent_page_id" 
  
  validates_uniqueness_of :url_title, :message => "must be unique within parent", :scope => :parent_page_id

  def self.find_by_url(url)
    
    if USE_PATH_CACHE
       page = find_by_path_cache(url)
    else
      tokens = url.split('/')
      page  =  find(:first,:conditions => [self.create_condition_string(tokens)]) 
    end
    
    raise ActiveRecord::RecordNotFound if page.nil?
    page
    
  end

def  after_save
 self.update_path_cache!
 
 
end


def update_path_cache!

 self.path_cache = self.full_path
 update_without_callbacks
 self.descendants.each { |d| d.update_path_cache! }

end 

def full_path

  if self.parent
    self.ancestors.collect(&:url_title).join("/") + "/" + self.url_title
  else
    self.url_title
  end

end




private 



def self.create_condition_string(tokens)
      first_token = tokens.pop  
      tokens.reverse!
      sql = "url_title = '" + first_token + "' AND parent_page_id = "

      if !tokens.length.zero? 
         tokens.each_index do |idx|
         sql += "(SELECT id FROM pages p#{idx} WHERE url_title = '" + tokens[idx] +  "' AND parent_page_id = "
         end
         brakets =  ')' * tokens.length
          sql += '0' + brakets
       else
          sql += '0'
       end
       sql

end

  

  

def self.full_path

  if self.parent
    self.ancestors.collect(&:url_title).join("/") + "/" + self.url_title
  else
    self.url_title
  end

end

end
