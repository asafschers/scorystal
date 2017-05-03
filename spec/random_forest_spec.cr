require "./spec_helper"
require "spec2"

Spec2.describe RandomForest do
  SHOULD_APPROVE = "should_approve"
  SHOULD_DECLINE = "should_decline"

  let(:rf_file) { "spec/pmmls/rf_file.pmml" }
  let(:rf_text) { File.read(rf_file) }
  let(:xml) { XML.parse(rf_text, XML::ParserOptions::NOBLANKS || XML::ParserOptions.default || XML::ParserOptions::NSCLEAN) }
  let(:random_forest) { RandomForest.new(xml) }

  def categorial_features
    {
      "f5" => "Linux",
      "f6" => "Chrome",
      "f13" => "F1L",
      "f15" => "f",
      "f19" => "cellular",
      "f20" => "Corporate",
      "f26" => "ValidDomain",
      "f31" => "female",
      "f35" => "f",
      "f36" => "F1L",
      "f38" => "NO_EA_LOCATION",
      "f49" => "field mismatch",
      "f53" => "field_match",
      "f54" => "field mismatch",
      "f55" => "FL",
      "f63" => "match",
      "f65" => "all_uppercase",
      "f66" => "all_lowercase",
      "f67" => "Missing"
    }
  end

  def approve_features
    features = categorial_features
    (1..67).each { |i| features["f#{i}"] = "0" if !features.has_key?("f#{i}") }
    features
  end

  def decline_features
    features = categorial_features
    (1..67).each { |i| features["f#{i}"] = "3000" if !features.has_key?("f#{i}") }
    features
  end

  it "predicts approve" do
    expect(random_forest.predict(approve_features)).to eq SHOULD_APPROVE
    decisions_count = random_forest.decisions_count(approve_features)
    expect(decisions_count[SHOULD_APPROVE]).to eq 12
    expect(decisions_count[SHOULD_DECLINE]).to eq 3
  end

  it "predicts decline" do
    expect(random_forest.predict(decline_features)).to eq SHOULD_DECLINE
    decisions_count = random_forest.decisions_count(decline_features)
    expect(decisions_count[SHOULD_APPROVE]).to eq 6
    expect(decisions_count[SHOULD_DECLINE]).to eq 9
  end
end
