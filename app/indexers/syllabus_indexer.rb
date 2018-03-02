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
      matches = /^([A-Z]{2,4})\s?([0-9]{3}.*)$/.match(object.title.first.upcase)
      if matches and (3 == matches.size)
        solr_doc['title_tesim'] = matches[1] + ' ' + matches[2]
        solr_doc['course_prefix_number_concat_tesim'] = matches[1] + matches[2]
      end
    end
  end
end
