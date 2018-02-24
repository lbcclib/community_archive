# Generated via
#  `rails generate hyrax:work OpenEducationalResource`
class OpenEducationalResource < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = OpenEducationalResourceIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  self.human_readable_type = 'Open Educational Resource'

  property :crn, predicate: ::RDF::URI('http://purl.org/dc/terms/references'), multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :year_course_taught, predicate: ::RDF::URI('http://purl.org/dc/terms/issued'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end
  property :tech_requirement, predicate:  ::RDF::URI('http://id.loc.gov/ontologies/bibframe/systemRequirement'), multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :material_type, predicate:  ::RDF::URI('http://purl.org/dc/terms/type'), multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :media_format, predicate:  ::RDF::URI('http://purl.org/dc/terms/MediaType'), multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :sublevel, predicate: ::RDF::URI('http://purl.org/dc/terms/educationLevel'), multiple: true do |index|
    index.as :stored_searchable, :facetable
  end

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
