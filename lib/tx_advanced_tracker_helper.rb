module TxAdvancedTrackerHelper
  def self.is_in_roadmap?( tracker_id )
    all_trackers.select { |tracker| tracker.id == tracker_id }.first.is_in_roadmap
  end
  def self.is_bug?( tracker_id )
    all_trackers.select { |tracker| tracker.id == tracker_id }.first.is_bug
  end
  def self.is_sidejob?( tracker_id )
    all_trackers.select { |tracker| tracker.id == tracker_id }.first.is_sidejob
  end
  def self.is_patchnote?( tracker_id )
    all_trackers.select { |tracker| tracker.id == tracker_id }.first.is_patchnote
  end
  def self.is_exception?( tracker_id )
    all_trackers.select { |tracker| tracker.id == tracker_id }.first.is_exception
  end

  @@all_trackers = nil
  @@all_tracker_updated_at = nil

  def self.all_trackers
    if @@all_trackers.nil? || @@all_tracker_updated_at < Time.now - 5.minute then
      @@all_trackers = Tracker.all
      @@all_tracker_updated_at = Time.now
    end
    @@all_trackers
  end
end