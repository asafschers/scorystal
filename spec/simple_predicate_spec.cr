require "./spec_helper"
require "spec2"

Spec2.describe SimplePredicate do

  context "less or equal predicate" do
    let (:pred_string) { %(<SimplePredicate field="f33" operator="lessOrEqual" value="18.8513846048894"/>) }
    let (:pred_xml) { XML.parse(pred_string) }
    let (:predicate) { SimplePredicate.new(pred_xml.children.first) }

    it "returns true" do
      expect(predicate.true?({"f33" => 18})).to eq(true)
    end

    it "returns false" do
      expect(predicate.true?({"f33" => 19})).to eq(false)
    end
  end

  context "is missing predicate" do
    let (:pred_string) { %(<SimplePredicate field="f33" operator="isMissing"/>) }
    let (:pred_xml) { XML.parse(pred_string) }
    let (:predicate) { SimplePredicate.new(pred_xml.children.first) }

    it "returns true" do
      expect(predicate.true?({"f33" => nil})).to eq(true)
    end

    it "returns false" do
      expect(predicate.true?({} of String => String)).to eq(true)
    end

    it "returns false" do
      expect(predicate.true?({"f33" => 6})).to eq(false)
    end
  end

  context "equals predicate" do
    let (:pred_string) { %(<SimplePredicate field="f33" operator="equal" value="f2v3"/>) }
    let (:pred_xml) { XML.parse(pred_string) }
    let (:predicate) { SimplePredicate.new(pred_xml.children.first) }

    it "returns true" do
      expect(predicate.true?({"f33" => "f2v3"})).to eq(true)
    end

    it "returns true" do
      expect(predicate.true?({"f33" => nil})).to eq(false)
    end

    it "returns false" do
      expect(predicate.true?({} of String => String)).to eq(false)
    end
  end

end
