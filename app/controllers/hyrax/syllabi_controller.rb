# Generated via
#  `rails generate hyrax:work NewspaperIssue`

module Hyrax
  class SyllabiController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Syllabus

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::SyllabusPresenter
  end
end
