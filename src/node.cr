class Node

  getter :children, :predicate_string, :decision, :predicate

  @predicate : ((SimplePredicate | SimpleSetPredicate | DummyPredicate))
  @children : Array(Node)
  @decision : String
  @predicate_string : String

  def initialize(xml : XML::Node)
    children = xml.children
    @predicate_string = xml.children[0].to_s
    @predicate = predicate(children)
    @children = Array(Node).new
    @decision = xml["score"]?.to_s

    return if children.size == 1

    @children << Node.new(children[1]) if children.size > 1
    @children << Node.new(children[2]) if children.size > 2
    @children << Node.new(children[3]) if children.size > 3
  end

  def true?(features)
    @predicate.nil? || @predicate.true?(features)
  end

  private def predicate(children)
    return DummyPredicate.new if children.size == 0
    pred_xml = children[0]
    return SimplePredicate.new(pred_xml) if pred_xml.name == "SimplePredicate"
    return SimpleSetPredicate.new(pred_xml) if pred_xml.name == "SimpleSetPredicate"
    return DummyPredicate.new
  end
end
