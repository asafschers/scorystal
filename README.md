[![Build Status](https://travis-ci.org/asafschers/scorystal.svg?branch=master)](https://travis-ci.org/asafschers/scorystal)

# Scorystal

Crystal scoring API for Predictive Model Markup Language (PMML).

Currently supports random forest and gradient boosted models.

Will be happy to implement new kinds of models by demand, or assist with any other issue.

Contact me here or at aschers@gmail.com.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  scorystal:
    github: asafschers/scorystal
```

## Usage

```crystal
require "scorystal"

# Parse PMML file
pmml_text = File.read("spec/pmmls/gbm.pmml")
parsed_pmml = XML.parse(pmml_text, XML::ParserOptions::NOBLANKS)

# Set features hash

json = %({"F1":null,"F2":21371,"F3":"AA"}")
features = Scorystal.features_hash(json)

# Gradient Boosted Model

gbm = Gbm.new(parsed_pmml)
puts gbm.score(features)

# Random Forest

rf = RandomForest.new(parsed_pmml)
puts rf.decisions_count(features)

```

## Contributing

1. Fork it ( https://github.com/asafschers/scorystal/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[asafschers]](https://github.com/asafschers) asaf schers - creator, maintainer
