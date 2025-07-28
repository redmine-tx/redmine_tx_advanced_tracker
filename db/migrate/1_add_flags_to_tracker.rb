class AddFlagsToTracker < ActiveRecord::Migration[5.2]
    def up
      add_column :trackers, :is_sidejob, :boolean, null: false, default: false
      add_column :trackers, :is_bug, :boolean, null: false, default: false
      add_column :trackers, :is_patchnote, :boolean, null: false, default: false
      add_column :trackers, :is_exception, :boolean, null: false, default: false
    end
  
    def down
      remove_column :trackers, :is_sidejob
      remove_column :trackers, :is_bug
      remove_column :trackers, :is_patchnote
      remove_column :trackers, :is_exception
    end
  end 
    
  