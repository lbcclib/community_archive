namespace :derivatives do
	desc 'Loop over all objects and regenerative derivatives'
	task regenerate: [:environment] do
		Hyrax.config.curation_concerns.each do |concern|
      		concern.all.map(&:members).each do |members|
        		next if members.blank?
        		members.each do |member|
          			next unless member.is_a?(FileSet)
          			if member.original_file.nil?
            				puts "No :original_file relation returned for FileSet (#{member.id})"
            				next
          			end
		       		wrapper = JobIoWrapper.find_by(file_set_id: member.id)
       				path_hint = wrapper.uploaded_file ? wrapper.uploaded_file.uploader.path : wrapper.path
          			Rails.logger.debug("Regenerating derivatives for FileSet #{member.id} in the background")
          			puts "Queueing (#{member.id})"
          			CharacterizeJob.perform_later(member, member.original_file.id, path_hint)
				sleep(40)
			end
		end
	end
	end
end
