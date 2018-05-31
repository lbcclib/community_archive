# Generated via
#  `rails generate hyrax:work Video`
module Hyrax
  class VideoForm < Hyrax::Forms::WorkForm
    self.model_class = ::Video
    self.terms += [:resource_type, :duration_in_minutes]
    self.required_fields += [:date_created, :duration_in_minutes]
  end
end
