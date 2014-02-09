namespace :category do
  desc "Generate Default Activities"
  task :generate_default => :environment do
    ["CSS", "HTML", "jQuery", "Javascript", "Node.js", "Arduino + Processing", "Agile Development", 
      "Photoshop", "Illustrator", "Design Principles"].each do |category_name|
        Category.create(name: category_name)
    end
  end

end