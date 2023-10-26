class AddLikecounterAndCommentcounterToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :likecounter, :integer
    add_column :posts, :comments_counter, :integer
  end
end
