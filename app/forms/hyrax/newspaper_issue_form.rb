# Generated via
#  `rails generate hyrax:work NewspaperIssue`
module Hyrax
  class NewspaperIssueForm < Hyrax::Forms::WorkForm
    self.model_class = ::NewspaperIssue
    self.required_fields += [:date_created, :volume, :edition]
    self.required_fields -= [:creator, :rights_statement]
    self.terms += [:contributor_list, :volume, :edition]
    self.terms -= [:abstract, :creator, :contributor, :description, :identifier, :license, :source, :subject, :publisher, :related_url]
  end
end
