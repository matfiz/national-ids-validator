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

  describe "gender" do
    it "should return nil when invalid number provided" do
      expect(NationalIdsValidator.new("123", "NO").gender).to be_nil
    end

    context "given the NO personal numbers of man" do
        [
            "12030599916",
            "12030599754",
            "12030599592",
            "12030599169",
            "12030598537"
        ].each do |personal_number|

          it "#{personal_number.inspect} gener should be 0 - man" do
            expect(NationalIdsValidator.new(personal_number, "NO").gender).to equal(0)
          end
        end
      end

    context "given the NO personal numbers of woman" do
      [
          "14030599218",
          "14030597479",
          "14030594836",
          "14030593023",
          "14030594674"
      ].each do |personal_number|
        it "#{personal_number.inspect} gener should be 1 - woman" do
          expect(NationalIdsValidator.new(personal_number, "NO").gender).to equal(0)
        end
      end
    end
  end
end