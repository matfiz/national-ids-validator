require 'spec_helper'

class TestPolish < TestModel
  validates :personal_number, :national_id => {country: "PL"}
end

class TestPolishWithMessage < TestModel
  validates :personal_number, :national_id => {country: "PL", message: "is not valid personal number"}
end

class TestPolishAllowsNil < TestModel
  validates :personal_number, :national_id => {country: "PL", message: "is not valid personal number", allow_nil: true}
end

class TestPolishAllowsNilFalse < TestModel
  validates :personal_number, :national_id => {country: "PL", message: "is not valid personal number", allow_nil: false}
end

describe NationalIdsValidator do

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