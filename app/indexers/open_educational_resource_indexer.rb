# Generated via
#  `rails generate hyrax:work OpenEducationalResource`
class OpenEducationalResourceIndexer < CommunityArchiveIndexer

  # All works should be at the lower division level
  def generate_solr_document
   super
   super.tap do |solr_doc|
     solr_doc['sublevel_ssim'] = 'Community College / Lower Division'
     solr_doc['primary_audience_ssim'] = 'Other'
     solr_doc['providing_institution_ssim'] = 'Linn-Benton Community College'
   end
  end
end
