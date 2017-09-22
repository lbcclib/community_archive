# Generated via
#  `rails generate hyrax:work NewspaperIssue`
module Hyrax
  class NewspaperIssueForm < Hyrax::Forms::WorkForm
    self.model_class = ::NewspaperIssue
    self.required_fields += [:contributor_list, :date_created]
    self.required_fields -= [:creator, :rights_statement]
    self.terms += [:contributor_list]
    self.terms -= [:abstract, :creator, :contributor, :description, :identifier, :source, :subject, :publisher, :related_url]
  end
end
