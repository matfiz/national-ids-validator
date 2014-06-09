require 'spec_helper'

class TestNorwegian < TestModel
  validates :personal_number, :national_id => {country: "NO"}
end

describe NationalIdsValidator do

  describe "validation" do
    context "given the valid NO personal numbers" do
      [
          "15051273920",
          "12039449925",
          "12039449097",
          "03121298286",
          " 03121298286 "
      ].each do |personal_number|

        it "#{personal_number.inspect} should be valid" do
          expect(TestNorwegian.new(:personal_number => personal_number, country: "NO")).to be_valid
        end

      end

    end

    context "given the invalid NO personal numbers", focus: true do
      [
          "",
          "123",
          "86020219131",
          "@bar.com",
          "86020219131\n<script>alert('hello')</script>"
      ].each do |personal_number|

        it "#{personal_number.inspect} should not be valid" do
          expect(TestNorwegian.new(:personal_number => personal_number, country: "NO")).not_to be_valid
        end

      end
    end
  end

end