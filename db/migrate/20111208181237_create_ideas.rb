class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.string :title
      t.integer :user_id
      t.integer :isactive

      t.timestamps
    end
    add_index :ideas, :user_id
  end
  
  def self.down
    drop_table :ideas
  end
end
