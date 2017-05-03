namespace :export do
  desc "Prints Company.all and Workplace.all in a seeds.rb way."
  task :seeds_format => :environment do
  Workplace.order(:id).all.each do |place|
      puts "Workplace.create(#{place.serializable_hash.delete_if {|key, value| ['created_at', 'updated_at', 'id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
   end

  Industry.order(:id).all.each do |place|
       puts "Industry.create(#{place.serializable_hash.delete_if {|key, value| ['created_at', 'updated_at', 'id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
  end
 end
end
