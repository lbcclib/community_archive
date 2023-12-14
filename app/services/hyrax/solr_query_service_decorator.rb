# frozen_string_literal: true

# OVERRIDE FILE from Hyrax v3.1.0 - delete after upgrading to Hyrax >= v4.0.0

module Hyrax
  # This decorator backports a conceptual fix from Hyrax v4.0.0. It
  # prevents a `414 Request-URI Too Long` RSolr error from being
  # thrown on the "Review Submissions" page (/admin/workflows).
  #
  # This is a "conceptual" fix because it is not a line-for-line change
  # from Hyrax v4.0.0. Rather, it backports the concept that using
  # POST instead of GET allows for larger requests to be sent to Solr.
  #
  # Reference: https://github.com/samvera/hyrax/issues/5926
  module SolrQueryServiceDecorator
    ##
    # @return [Enumerable<SolrDocument>]
    def solr_documents
      # OVERRIDE: replace #get with solr_service#post
      solr_service.post(build)['response']['docs'].map { |doc| self.class.document_model.new(doc) }
    end
  end
end

Hyrax::SolrQueryService.prepend(Hyrax::SolrQueryServiceDecorator)
