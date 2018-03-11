# Generated via
#  `rails generate hyrax:work Syllabus`
module Hyrax
  class SyllabusPresenter < Hyrax::WorkShowPresenter
    delegate :crn, :term_course_taught, :year_course_taught, to: :solr_document
  end
end
