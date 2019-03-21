# Generated via
#  `rails generate hyrax:work Syllabus`
class SyllabusIndexer < CommunityArchiveIndexer
  def generate_solr_document
  # Making sure that course numbers are indexed both with and without spaces
    super.tap do |solr_doc|
      terms = Hash['1', 'Summer', '2', 'Fall', '3', 'Winter', '4', 'Spring']
      relevant_terms = []
      object.crn.each do |crn|
        if terms.has_key? crn[0,1]
          relevant_terms << terms[crn[0,1]]
	end
      end
      solr_doc['term_course_taught_tesim'] = relevant_terms.uniq

      solr_doc['title_tesim'] = []
      solr_doc['course_prefix_number_concat_tesim'] = []
      object.title.each do |title| 
        matches = /^([A-Z]{2,4})\s?([0-9]{3,4})([A-Z]?)$/.match(title.upcase)
        if matches and (4 == matches.size)
          if ('' == matches[3])
	    puts solr_doc['title_tesim'].class
            solr_doc['title_tesim'] << matches[1] + ' ' + matches[2]
            solr_doc['course_prefix_number_concat_tesim'] << matches[1] + matches[2]
	  else
            solr_doc['title_tesim'] << matches[1] + ' ' + matches[2] + matches[3]
            solr_doc['course_prefix_number_concat_tesim'] << matches[1] + matches[2] + matches[3] + ' ' + matches[1] + matches[2] + ' ' + matches[2] + ' ' + matches[3]
          end
	else
          solr_doc['title_tesim'] << title.upcase
        end
      end
    end
  end
end
