class SimpleSetPredicate

  IS_IN = "isIn"

  @field : String
  @operator : String
  @array : Array(String)

  def initialize(pred_xml)
    @field = pred_xml["field"] 
    @operator = pred_xml["booleanOperator"]
    @array = single_or_quoted_words(pred_xml.content)
  end

  def true?(features)
    @array.includes? features[@field] if @operator == IS_IN
  end

  private def single_or_quoted_words(string)
    string.split(/\s(?=(?:[^"]|"[^"]*")*$)/).
      reject{ |a| a.empty? }.
      map { |w| w.tr(%("),%())}
  end
end
