require 'spec_helper'

class TestPolish < TestModel
  validates :personal_number, :national_id => {country: "PL"}
end

describe NationalIdsValidator do

  describe "validation" do
    context "given the valid PL personal numbers" do
      [
          "86020219132",
          "86040807100",
          "02242100603",
          " 02242100603 "
      ].each do |personal_number|

        it "#{personal_number.inspect} should be valid" do
          expect(TestPolish.new(:personal_number => personal_number)).to be_valid
        end

      end

    end

    context "given the invalid PL personal numbers" do
      [
          "",
          "123",
          "86020219131",
          "@bar.com",
          "86020219131\n<script>alert('hello')</script>"
      ].each do |personal_number|

        it "#{personal_number.inspect} should not be valid" do
          expect(TestPolish.new(:personal_number => personal_number)).not_to be_valid
        end

      end
    end
  end

end