require "./decision_tree"

class Gbm
  GBM_FOREST_XPATH = %(//Segmentation[@multipleModelMethod="sum"])
  CONST_XPATH      = %(//Constant[@dataType="double"])

  @decision_trees : Array(DecisionTree)
  @const : Float64

  def initialize(xml : XML::Node)
    xml_trees = xml.xpath_node(GBM_FOREST_XPATH)

    if xml_trees
      @decision_trees = xml_trees.children.map{ |xml_tree|
        DecisionTree.new(xml_tree)
      }
    else
      @decision_trees = [] of DecisionTree
    end

    const_element = xml.xpath_node(CONST_XPATH)
    @const = 0.0
    @const = const_element.content.to_f if const_element && const_element.content.to_f?
  end

  def tree_count
    @decision_trees.size
  end

  def score(features)
    x = @decision_trees.sum { |dt|
      score = dt.decide(features)
      if score
        score.to_f
      else
        raise("Non float score for GBM")
      end
    } + @const
    Math.exp(x) / (1 + Math.exp(x))
  end
end
