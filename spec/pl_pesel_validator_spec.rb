require 'spec_helper'

class TestPolish < TestModel
  validates :personal_id, :national_id => {country: "PL"}
end

class TestPolishWithMessage < TestModel
  validates :personal_id, :national_id => {country: "PL", message: "is not valid personal number"}
end

class TestPolishAllowsNil < TestModel
  validates :personal_id, :national_id => {country: "PL", message: "is not valid personal number", allow_nil: true}
end

class TestPolishAllowsNilFalse < TestModel
  validates :personal_id, :national_id => {country: "PL", message: "is not valid personal number", allow_nil: false}
end

class TestNorwegian < TestModel
  validates :personal_id, :national_id => {country: "NO"}
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

  describe "error messages" do
    context "when the message is not defined" do
      subject { TestPolish.new :personal_number => '12345678901' }
      before { subject.valid? }

      it "should add the default message" do
        expect(subject.errors[:personal_number]).to include "is invalid"
      end
    end

    context "when the message is defined" do
      subject { TestPolishWithMessage.new :personal_number => '12345678901' }
      before { subject.valid? }

      it "should add the customized message" do
        expect(subject.errors[:personal_number]).to include "is not valid personal number"
      end
    end
  end

  describe "nil personal number" do
    it "should not be valid when :allow_nil option is missing" do
      expect(TestPolish.new(:personal_number => nil)).not_to be_valid
    end

    it "should be valid when :allow_nil options is set to true" do
      expect(TestPolishAllowsNil.new(:personal_number => nil)).to be_valid
    end

    it "should not be valid when :allow_nil option is set to false" do
      expect(TestPolishAllowsNilFalse.new(:personal_number => nil)).not_to be_valid
    end
  end

end