require "./spec_helper"
require "spec2"

Spec2.describe Gbm do

  let(:gbm_file) { "spec/pmmls/gbm_file.pmml" }
  let(:gbm_text) { File.read(gbm_file) }
  let(:xml) { XML.parse(gbm_text, XML::ParserOptions::NOBLANKS) }
  let(:gbm) { Gbm.new(xml) }

  it "loads correct number of trees" do
    expect(gbm.tree_count).to eq 30
  end

  def approve_features
    features = {} of String => String
    (1..110).each { |i| features["f#{i}"] = "0" if  !features.has_key?("f#{i}") }
    features
  end

  def decline_features
    features = {} of String => String
    (1..110).each { |i| features["f#{i}"] = "3000" if !features.has_key?("f#{i}") }
    features
  end

  it "predicts approve" do
    expect(gbm.score(approve_features)).to eq 0.6736069972600348
  end

  it "predicts decline" do
    # expect(gbm.score(decline_features)).to eq 0.48682675281447374
  end
end
