require "./scorystal/*"
require "json"

module Scorystal

  class_property  logger = Logger.new(STDOUT)

  def self.features_hash(json)
    features = JSON.parse(json)
    hash_features = {}  of String => String
    features.each { |k, v|
      hash_features[k.to_s] = v.to_s
      hash_features[k.to_s] = "f" if v.to_s == "false"
      hash_features[k.to_s] = "t" if v.to_s == "true"
    }
    hash_features
  end
end
