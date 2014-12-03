class SvgoWrapper
  class << self
    def svgo_present?
      response = `echo "<svg xmlns='http://www.w3.org/2000/svg'></svg>" | svgo -i - -o - 2> /dev/null`
      !(response =~ /\A<svg/).nil?
    end
  end
end
