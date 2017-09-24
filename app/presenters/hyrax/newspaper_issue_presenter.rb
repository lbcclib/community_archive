# Generated via
#  `rails generate hyrax:work NewspaperIssue`
module Hyrax
  class NewspaperIssuePresenter < Hyrax::WorkShowPresenter
    delegate :edition, :volume, :contributor_list, to: :solr_document
  end
end
