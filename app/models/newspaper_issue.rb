# Generated via
#  `rails generate hyrax:work NewspaperIssue`
class NewspaperIssue < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  #include Hydra::Derivatives

  self.indexer = NewspaperIssueIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  self.human_readable_type = 'Newspaper Issue'

  property :contributor_list, predicate: ::RDF::URI('http://purl.org/dc/terms/contributor'), multiple: false do |index|
    index.as :stored_searchable
  end


  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
