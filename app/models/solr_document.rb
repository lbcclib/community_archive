# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include BlacklightOaiProvider::SolrDocument

  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior


  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models. 

  use_extension( Hydra::ContentNegotiation )

  def crn
    self[Solrizer.solr_name('crn')]
  end
  def term_course_taught
    self[Solrizer.solr_name('term_course_taught')]
  end
  def year_course_taught
    self[Solrizer.solr_name('year_course_taught')]
  end
  def edition
    self[Solrizer.solr_name('edition')]
  end
  def volume
    self[Solrizer.solr_name('volume')]
  end
  def contributor_list
    self[Solrizer.solr_name('contributor_list')]
  end
  def duration_in_minutes
    self[Solrizer.solr_name('duration_in_minutes')]
  end
  field_semantics.merge!(
    audience: 'primary_audience_ssim',
    contributor: 'contributor_tesim',
    creator: 'creator_tesim',
    date: 'date_created_tesim',
    description: 'description_tesim',
    educationLevel: 'sublevel_ssim',
    format: 'media_format_tesim',
    identifier: 'url_for_work_tesim',
    language: 'language_tesim',
    license: 'license_tesim',
    publisher: 'providing_institution_ssim',
    relation: 'nesting_collection__pathnames_ssim',
    rights: 'rights_statement_tesim',
    subject: 'subject_tesim',
    title: 'title_tesim',
    type: 'resource_type_tesim'
  )
end
