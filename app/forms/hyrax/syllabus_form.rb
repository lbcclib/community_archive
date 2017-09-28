# Generated via
#  `rails generate hyrax:work Syllabus`
module Hyrax
  class SyllabusForm < Hyrax::Forms::WorkForm
    self.model_class = ::Syllabus
    self.terms += [:resource_type]
  end
end
