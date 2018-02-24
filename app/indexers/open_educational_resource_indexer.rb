# Generated via
#  `rails generate hyrax:work OpenEducationalResource`
class OpenEducationalResourceIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata


  # All works should be at the lower division level
  def generate_solr_document
   super.tap do |solr_doc|
     solr_doc['sublevel_ssim'] = 'Community College / Lower Division'
   end
  end
end
