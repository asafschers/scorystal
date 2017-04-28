class SimplePredicate

  @field : String
  @operator : String
  @value : String

  GREATER_THAN = "greaterThan"
  LESS_THAN = "lessThan"
  LESS_OR_EQUAL = "lessOrEqual"
  GREATER_OR_EQUAL = "greaterOrEqual"
  MATH_OPS = [GREATER_THAN, LESS_THAN, LESS_OR_EQUAL, GREATER_OR_EQUAL]
  EQUAL = "equal"
  IS_MISSING = "isMissing"

  def initialize(pred_xml)
    @field = pred_xml["field"]
    @operator = pred_xml["operator"]
    return if @operator == IS_MISSING
    @value = pred_xml["value"]
  end

  def true?(features)
    return num_true?(features[@field]) if MATH_OPS.includes?(@operator)
    return features[@field]? == @value if @operator == EQUAL
    features[@field].nil? || !features.has_key?(@field) if @operator == IS_MISSING
  end

  def num_true?(feature : Nil|String)
    false
  end

  def num_true?(feature : Int32)
    curr_value = feature.to_f
    value = @value.to_f
    return curr_value > value if @operator == GREATER_THAN
    return curr_value < value if @operator == LESS_THAN
    return curr_value <= value if @operator == LESS_OR_EQUAL
    curr_value >= value if @operator == GREATER_OR_EQUAL
   end
end