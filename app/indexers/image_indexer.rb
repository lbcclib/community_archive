# Generated via
#  `rails generate hyrax:work Image`
class ImageIndexer < CommunityArchiveIndexer

  # Uncomment this block if you want to add custom indexing behavior:
   def generate_solr_document
    super.tap do |solr_doc|
     solr_doc['url_for_work_tesim'] = ['http://libarchive.linnbenton.edu/concern/images/' + object.id]
    end
   end
end
