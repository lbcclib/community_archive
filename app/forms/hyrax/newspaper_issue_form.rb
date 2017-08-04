# Generated via
#  `rails generate hyrax:work NewspaperIssue`
module Hyrax
  class NewspaperIssueForm < Hyrax::Forms::WorkForm
    self.model_class = ::NewspaperIssue
    self.terms += [:resource_type]
    self.terms -= [:source, :publisher]
  end
end
