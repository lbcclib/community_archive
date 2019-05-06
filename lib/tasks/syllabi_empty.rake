namespace :syllabi do
    namespace :empty do
        desc 'Generate a list of empty syllabus works'
        task :list => :environment do
            Syllabus.find_each do |w|
                if w.file_sets.empty?
                    puts "http://libarchive.linnbenton.edu/concern/syllabus/" + w.id
                end
            end
        end
    end
end
