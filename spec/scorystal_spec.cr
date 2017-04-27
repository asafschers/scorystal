require "./spec_helper"


describe Scorystal do
  # TODO: Write tests

  context "quotes" do

    it "returns true" do
      pred_string = "<SimpleSetPredicate field=\"f36\" booleanOperator=\"isIn\">
                        <Array n=\"6\" type=\"string\">&quot;Missing&quot;   &quot;No Match&quot;</Array>
                        </SimpleSetPredicate>"

      categorical_predicate = SimpleSetPredicate.new(pred_string)

      categorical_predicate.true?({f36: "No Match"}).should eq(true)
    end

    it "returns false" do
      pred_string = "<SimpleSetPredicate field=\"f36\" booleanOperator=\"isIn\">
                        <Array n=\"6\" type=\"string\">&quot;Missing&quot;   &quot;No Match&quot;</Array>
                        </SimpleSetPredicate>"

      categorical_predicate = SimpleSetPredicate.new(pred_string)

      categorical_predicate.true?({f36: "Match"}).should eq(false)
    end
  end

end
