require "./spec_helper"
require "spec2"

Spec2.describe Scorystal do

  let (:pred_xml) { XML.parse(node_string).children[0] }
  let (:simple_set_predicate) { SimpleSetPredicate.new(pred_xml) }

  context "quotes" do
    let(:node_string) {
      %(<SimpleSetPredicate field="f36" booleanOperator="isIn">
                        <Array n="6" type="string">&quot;Missing&quot;   &quot;No Match&quot;</Array>
                        </SimpleSetPredicate>)
    }

    it "returns true" do
      expect(simple_set_predicate.true?({f36: "No Match"})).to eq(true)
    end

    it "returns false" do
      expect(simple_set_predicate.true?({f36: "Match"})).to eq(false)
    end
  end

  context "no quotes" do
    let (:node_string) { %(<SimpleSetPredicate field="f36" booleanOperator="isIn">
                          <Array n="6" type="string">f2v1 f2v2 f2v3</Array>
                          </SimpleSetPredicate>)
                       }

    it "returns true" do
      expect(simple_set_predicate.true?({f36: "f2v2"})).to eq(true)
    end

    it "returns false" do
      expect(simple_set_predicate.true?({f36: "f2v4"})).to eq(false)
    end
  end
end
