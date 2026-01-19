Redmine::Plugin.register :redmine_tx_advanced_tracker do
  name 'Redmine Tx Advanced Tracker plugin'
  author 'KiHyun Kang'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

Rails.application.config.after_initialize do
  require_dependency File.expand_path('lib/tx_advanced_tracker_helper', File.dirname(__FILE__))
  require_dependency File.expand_path('lib/tx_advanced_tracker_hook', File.dirname(__FILE__))
  require_dependency File.expand_path('lib/tx_advanced_tracker_patch', File.dirname(__FILE__))
  
  #ApplicationController.helper TxAdvancedTrackerHelper
  Tracker.send(:include, TxAdvancedTrackerPatch)
end
