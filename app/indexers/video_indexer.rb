# Generated via
#  `rails generate hyrax:work Video`
class VideoIndexer < CommunityArchiveIndexer
  def generate_solr_document
    super.tap do |solr_doc|
      solr_doc['resource_type_sim'] = 'Video'
    end
  end
end
