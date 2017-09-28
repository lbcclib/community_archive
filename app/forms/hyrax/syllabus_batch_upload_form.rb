# Generated via
#  `rails generate hyrax:work Syllabus`
module Hyrax
  class SyllabusBatchUploadForm < Hyrax::Forms::BatchUploadForm
    self.terms -= [:description, :publisher, :date_created, :subject, :identifier, :based_near, :related_url, :source]
    self.terms += [:year_course_taught, :course_number]
    self.required_fields += [:year_course_taught]
    self.required_fields -= [:keyword]
  end
end
