require "logger"

class DecisionTree

  getter :root

  @id : String
  @root : Node

  def initialize(tree_xml)
    @id = tree_xml["id"]
    root_xml = tree_xml.xpath_node("TreeModel/Node")
    if root_xml
      @root = Node.new(root_xml)
    else
      raise "Bad tree xml: #{@id}"
    end
  end

  def decide(features)
    curr = @root

    while curr.decision == ""
      prev = curr
      curr = step(curr, features)
      return if didnt_step?(curr, prev)
    end

    curr.decision
  end

  private def step(curr, features)
    curr = step_on_true(curr, features, 0)
    curr = step_on_true(curr, features, 1)
    curr = step_on_true(curr, features, 2)
    curr
  end

  private def step_on_true(curr, features, num)
    return curr.children[num] if curr.children && num < curr.children.size && curr.children[num].true?(features)
    curr
  end

  private def didnt_step?(curr, prev)
    return false if (prev.predicate != curr.predicate)
    Scorystal.logger.error("Null tree: #{@id}, bad feature: #{curr.children[0].predicate_string }")
    true
  end
end
