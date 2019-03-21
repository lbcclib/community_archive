# Generated via
#  `rails generate hyrax:work Document`
class CommunityArchiveIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata


  def generate_solr_document
  super.tap do |solr_doc|
    solr_doc['title_for_sorting_tesi'] = object.title.first
    solr_doc['date_created_for_sorting_tesi'] = object.date_created.first
  end
end
