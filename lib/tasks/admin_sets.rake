# frozen_string_literal: true

namespace :admin_sets do
  desc 'Merges works (no permissions/roles) from the second admin_set into the first, then deletes the second set'
  task :merge, %i[keep remove] => :environment do |_task, sets|
    begin
      set_to_keep = AdminSet.find sets[:keep]
      set_to_remove = AdminSet.find sets[:remove]
    rescue ActiveFedora::ObjectNotFoundError
      raise 'The admin set you provided was invalid.'
    end

    Hyrax.config.registered_curation_concern_types.each do |work_type|
      works = work_type.constantize.where admin_set_tesim: set_to_remove.title
      puts "Migrating #{works.count} #{work_type} works"
      works.each do |work|
        work.admin_set_id = set_to_keep.id
        work.save
      end
    end

    puts 'Deleting the unneeded admin set'
    set_to_remove.destroy
  end
end
