# Based on work from https://github.com/balexand/email_validator
class NationalIdValidator < ActiveModel::EachValidator
  @@default_options = {country: "PL"}

  def self.default_options
    @@default_options
  end

  def validate_each(record, attribute, value)
    options = @@default_options.merge(self.options)
    # name_validation = options[:strict_mode] ? "-a-z0-9+._" : "^@\\s"
    record.errors.add(attribute, options[:message] || :invalid) unless NationalIdsValidator.valid?(value,options[:country])
  end
end