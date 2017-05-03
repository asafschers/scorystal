class RandomForest
  RF_FOREST_XPATH = "PMML/MiningModel/Segmentation"

  @decision_trees : Array(DecisionTree)

  def initialize(xml : XML::Node)
    xml_trees = xml.xpath_node("PMML/MiningModel/Segmentation")

    if xml_trees
      @decision_trees = xml_trees.children.map { |xml_tree|
        DecisionTree.new(xml_tree)
      }
    else
      @decision_trees = [] of DecisionTree
    end
  end

  def decisions_count(features)
    decisions = @decision_trees.map { |decision_tree|
      decision_tree.decide(features)
    }

    res = {} of String => Int32
    decisions.compact.each { |dt|
      res[dt] = 0 unless res.has_key?(dt)
      res[dt] += 1
    }
    res
  end

  def predict(features)
    decisions_count(features).max_by {|_, v|  v }[0]
  end
end
