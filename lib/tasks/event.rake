namespace :event do
  desc "Generate Events"
  task :generate_default_events => :environment do
    ["CSS/HTML", "Ruby", "JavaScript", "JQuery", "Software Craftsmanship"].each do |event_title|
        Event.create!(title: event_title, date: Time.now, body: "A course in a language that will be discussed" )
      
    end
  end

end
