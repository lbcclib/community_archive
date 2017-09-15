# Service to add the Accessibility Statements controlled vocabulary
module AccessibilityStatementsService
  mattr_accessor :authority
  self.authority = Qa::Authorities::Local.subauthority_for('accessibility_statements')

  def self.select_all_options
    authority.all.map do |element|
      [element[:label], element[:id]]
    end
  end

  def self.label(id)
    authority.find(id).fetch('term')
  end
end
