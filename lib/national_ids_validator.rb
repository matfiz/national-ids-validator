require "national-ids-validator/version"
require "yaml"
require "national-ids-validator/validator" #if defined? ActiveModel

class NationalIdsValidator

  SUPPORTED_COUNTRY_CODES = %w(PL NO)

  def self.specifications
    @@rules ||= YAML.load_file(File.expand_path("national-ids-validator/rules.yml", File.dirname(__FILE__)))
  end

  def initialize(value,country_code)
    @country_code = country_code.to_s.strip.gsub(/\s+/, '').upcase
    @value = value.to_s.strip.gsub(/\s+/, '').upcase
    unless self.class::SUPPORTED_COUNTRY_CODES.include?(@country_code)
      raise RuntimeError.new("Unexpected country code '#{country_code}' that is not yet supported")
    end
  end

  def self.valid?(value,code)
    new(value,code).valid?
  end

  def valid?
    valid_check_digits? && valid_length?
  end

  def valid_length?
    !!specification && specification['length'] == @value.length
  end

  def valid_check_digits?
    status = false
    v = number_data

    case @country_code
      when "NO"
        #http://no.wikipedia.org/wiki/F%C3%B8dselsnummer
        #first control digit
        first_sum = 0
        first_sum += 3*v["day"][0]+7*v["day"][1]+6*v["month"][0]+1*v["month"][1]+8*v["day"][0]+9*v["day"][1]
        first_sum += 4*v["individual"][0]+5*v["individual"][1]+2*v["individual"][2]
        first_digit = 11 - (first_sum % 11)
        #second control digit
        second_sum = 0
        second_sum += 5*v["day"][0]+4*v["day"][1]+3*v["month"][0]+2*v["month"][1]+7*v["day"][0]+6*v["day"][1]
        second_sum += 5*v["individual"][0]+4*v["individual"][1]+3*v["individual"][2]+2*first_digit
        second_digit = 11 - (second_sum % 11)
        if first_digit == v["control"][0] && second_digit == v["control"][1]
          status = true
        end

      when "PL"
    end
    return status
  end



  private




  def specification
    @specification ||= self.class.specifications[@country_code.downcase]
  end

  def number_data
    @number_data ||= Regexp.new("^#{specification['regexp']}$").match(value) if specification
  end

  def method_missing(method_name, *args)
    respond_to?(method_name) ? number_data[method_name] : super
  end

  def respond_to_missing?(method_name, include_private=false)
    (number_data && number_data.names.include?(method_name.to_s)) || super
  end






end