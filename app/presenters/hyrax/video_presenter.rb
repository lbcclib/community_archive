# Generated via
#  `rails generate hyrax:work Video`
module Hyrax
  class VideoPresenter < Hyrax::WorkShowPresenter
    delegate :duration_in_minutes, to: :solr_document
  end
end
