# Generated via
#  `rails generate hyrax:work Syllabus`
module Hyrax
  class SyllabusForm < Hyrax::Forms::WorkForm
    self.model_class = ::Syllabus
    self.terms -= [:description, :publisher, :date_created, :subject, :identifier, :based_near, :related_url, :source]
    self.terms += [:year_course_taught, :crn]
    self.required_fields += [:year_course_taught, :crn]
    self.required_fields -= [:keyword, :rights_statement]
  end
end
