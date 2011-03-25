module StringUtils
  # Pass in a phrase containing a token with both singular and plural forms along with a count,
  # and the phrase with the correct singular or plural form is returned.
  #
  # Example:
  #
  #   pluralize_phrase("{{count}} {{person||people}} {{has||have}} unusual facial hair.", 3) =>
  #     "3 people have unusual facial hair."
  #
  def pluralize_phrase(string, count) 
    return string if string.nil? or count.nil?                     
    
    # match[:all] == the entire token: '{{person||people}}'
    # match[:singular] == singular form: 'person'
    # match[:plural] == plural form: 'people'
    token_pattern = /(?<all>{{(?<singular>\S+)\|\|(?<plural>\S+)}})/
    form = (count == 1) ? :singular : :plural

    while match = string.match(token_pattern) do       
      string.gsub! match[:all], match[form]
    end
                                                                               
    string.gsub "{{count}}", count.to_s
  end
end