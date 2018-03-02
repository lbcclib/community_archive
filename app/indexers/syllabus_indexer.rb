# Generated via
#  `rails generate hyrax:work Syllabus`
class SyllabusIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata


  def generate_solr_document
  # Making sure that course numbers are indexed both with and without spaces
    super.tap do |solr_doc|
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
