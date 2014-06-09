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
    valid_length? && valid_check_digits?
  end

  def valid_length?
    !!specification && specification['length'] == @value.length
  end

  def valid_check_digits?
    status = false
    v = self.number_data
    # binding.pry

    case @country_code
      when "NO"
        #http://no.wikipedia.org/wiki/F%C3%B8dselsnummer
        #first control digit
        weights1 = specification['weights1']
        first_sum = 0
        0.upto(@value.length - 3).each do |i|
          first_sum += @value[i].to_i*weights1[i].to_i
        end
        first_digit = 11 - (first_sum % 11)
        #second control digit
        weights2 = specification['weights2']
        second_sum = 0
        0.upto(@value.length - 2).each do |i|
          second_sum += @value[i].to_i*weights2[i].to_i
        end
        second_digit = 11 - (second_sum % 11)
        #check digits
        calculated = [first_digit, second_digit].map!{|k| k == 11 ? 0 : k}
        control = [v["control"][0].to_i, v["control"][1].to_i]
        if calculated[0] == control[0] && calculated[1] == control[1]
          status = true
        end
        # binding.pry
      when "PL"
    end

    return status
  end

  def number_data
    @number_data ||= Regexp.new("^#{specification['regexp']}$").match(@value) if specification
  end


  private




  def specification
    @specification ||= self.class.specifications[@country_code.downcase]
  end



  # def method_missing(method_name, *args)
  #   respond_to?(method_name) ? number_data[method_name] : super
  # end
  #
  # def respond_to_missing?(method_name, include_private=false)
  #   (number_data && number_data.names.include?(method_name.to_s)) || super
  # end






end