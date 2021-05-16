desc "This task is called by the Heroku scheduler add-on"
task :reset_counts => :environment do
  puts "Resetting counts..."
  TweetView.reset_counts
  puts "done."
end