module TxAdvancedTrackerPatch
    extend ActiveSupport::Concern
  
    included do
      safe_attributes(
        'name',
        'default_status_id',
        'is_in_roadmap',
        'core_fields',
        'position',
        'custom_field_ids',
        'project_ids',
        'description',
        'is_sidejob',
        'is_bug',
        'is_patchnote',
        'is_exception'
        )
    end

    module ClassMethods
      def is_in_roadmap?( tracker_id )
        TxAdvancedTrackerHelper.is_in_roadmap?( tracker_id )
      end
      def is_bug?( tracker_id )
        TxAdvancedTrackerHelper.is_bug?( tracker_id )
      end
      def is_sidejob?( tracker_id )
        TxAdvancedTrackerHelper.is_sidejob?( tracker_id )
      end 
      def is_patchnote?( tracker_id )
        TxAdvancedTrackerHelper.is_patchnote?( tracker_id )
      end
      def is_exception?( tracker_id )
        TxAdvancedTrackerHelper.is_exception?( tracker_id )
      end

      def bug_trackers_ids
        TxAdvancedTrackerHelper.all_trackers.select { |tracker| tracker.is_bug }.map( &:id )
      end

      def sidejob_trackers_ids
        TxAdvancedTrackerHelper.all_trackers.select { |tracker| tracker.is_sidejob }.map( &:id )
      end

      def roadmap_trackers_ids
        TxAdvancedTrackerHelper.all_trackers.select { |tracker| tracker.is_in_roadmap }.map( &:id )
      end
      
      def exception_trackers_ids
        TxAdvancedTrackerHelper.all_trackers.select { |tracker| tracker.is_exception }.map( &:id )
      end
    end
end