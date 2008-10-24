class AddPathCache < ActiveRecord::Migration
  def self.up

    add_column(:pages, :path_cache, :string)

  end

  def self.down
    remove_column(:pages, :path_cache)
  end
end
