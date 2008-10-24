require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
 
namespace :notes do
  desc 'List notes  in all .rb files under /'
  task(:list) do
      FileList["app/**/*.rb"].egrep(/NOTE/)
      FileList["test/**/*.rb"].egrep(/NOTE/)
      FileList["spec/**/*.rb"].egrep(/NOTE/)
    end
end

