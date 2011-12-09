class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.integer :user_id
      t.integer :responseid
      t.string :voice

      t.timestamps
    end
    
    add_index :responses, :user_id
     add_index :responses, :responseid
  end
  
    def self.down
    drop_table :responses
    end
end
