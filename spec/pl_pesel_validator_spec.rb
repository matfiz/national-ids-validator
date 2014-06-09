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

  describe "gender" do
    it "should return nil when invalid number provided" do
      expect(NationalIdsValidator.new("123", "PL").gender).to be_nil
    end

    context "given the PL PESEL of man" do
      [
          "78111914774",
          "04301513670",
          "20021804054",
          "49121503797",
          "76053019771"
      ].each do |personal_number|

        it "#{personal_number.inspect} gender should be 0 - man" do
          expect(NationalIdsValidator.new(personal_number, "PL").gender).to equal(0)
        end
      end
    end

    context "given the PL PESEL of woman" do
      [
          "67070203144",
          "21121317741",
          "21022314928",
          "22050917321",
          "30122117724"
      ].each do |personal_number|
        it "#{personal_number.inspect} gender should be 1 - woman" do
          expect(NationalIdsValidator.new(personal_number, "PL").gender).to equal(0)
        end
      end
    end
  end

end