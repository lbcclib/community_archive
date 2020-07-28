# Generated via
#  `rails generate hyrax:work Video`
class Video < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = VideoIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  property :duration_in_minutes, predicate: ::RDF::URI('http://id.loc.gov/ontologies/bibframe/duration'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
