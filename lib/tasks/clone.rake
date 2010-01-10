namespace :worklists1 do
  desc "clone all v1 lists and recreate them in worklists2"
  task :clone_all, :needs => :environment do
    XmlUtilities.clone_all_v1_lists
  end
end