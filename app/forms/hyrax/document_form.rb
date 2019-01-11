# Generated via
#  `rails generate hyrax:work Document`
module Hyrax
  class DocumentForm < Hyrax::Forms::WorkForm
    self.model_class = ::Document
    self.terms += [:resource_type, :accessibility_statement]
    self.terms -= [:source]
    self.required_fields -= [:rights_statement]
  end
end
