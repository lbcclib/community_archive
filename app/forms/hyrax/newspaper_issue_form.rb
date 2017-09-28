# Generated via
#  `rails generate hyrax:work NewspaperIssue`
module Hyrax
  class NewspaperIssueForm < Hyrax::Forms::WorkForm
    self.model_class = ::NewspaperIssue
    self.terms += [:resource_type]
  end
end
