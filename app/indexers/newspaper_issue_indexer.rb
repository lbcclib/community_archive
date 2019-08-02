# Generated via
#  `rails generate hyrax:work NewspaperIssue`
class NewspaperIssueIndexer < CommunityArchiveIndexer

  # Uncomment this block if you want to add custom indexing behavior:
  def generate_solr_document
    super.tap do |solr_doc|
      solr_doc['url_for_work_tesim'] = ['http://libarchive.linnbenton.edu/concern/newspaper_issues/' + object.id]
    end
  end
end
