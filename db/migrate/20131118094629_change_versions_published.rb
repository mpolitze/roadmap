class ChangeVersionsPublished < ActiveRecord::Migration
  def change
    add_column :versions, :published_tmp, :boolean

    Version.reset_column_information # make the new column available to model methods
    Version.all.each do |v|
      v.published_tmp = v.published == 't' ? true : false
      v.save
    end

    remove_column :versions, :published
    rename_column :versions, :published_tmp, :published
  end
end
