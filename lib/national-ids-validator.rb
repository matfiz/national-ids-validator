require "national-ids-validator/version"
require "yaml"
require "national-ids-validator/validator" #if defined? ActiveModel

class NationalIdsValidator

  SUPPORTED_COUNTRY_CODES = %(PL NO)

  def self.specifications
    @@rules ||= YAML.load_file(File.expand_path("national-ids-validator/rules.yml", File.dirname(__FILE__)))
  end

  def initialize(value,country_code)
    @country_code = country_code.to_s.strip.gsub(/\s+/, '').upcase
    @value = value.to_s.strip.gsub(/\s+/, '').upcase
  end

  def self.valid?(code)
    new(value,code).valid?
  end

  def valid?
    valid_check_digits? && valid_length? && valid_country_code?
  end

  def valid_length?
    !!specification && specification['length'] == @code.length
  end

  private

  def specification
    @specification ||= self.class.specifications[country_code.downcase]
  end


end