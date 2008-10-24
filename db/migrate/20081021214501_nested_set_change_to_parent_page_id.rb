class NestedSetChangeToParentPageId < ActiveRecord::Migration
  def self.up
    rename_column :pages, :parent_id, :parent_page_id
  end

  def self.down
    rename_column :pages, :parent_page_id , :parent_id 
  end
end
