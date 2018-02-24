# Service to add the OERC second order subjects controlled vocabulary
module SecondOrderSubjectsService
  mattr_accessor :authority
  self.authority = Qa::Authorities::Local.subauthority_for('second_order_subjects')

  def self.select_all_options
    a = authority.all.map do |element|
      [element[:label], element[:id]]
    end
    return a.sort
  end

  def self.label(id)
    authority.find(id).fetch('term')
  end
end
