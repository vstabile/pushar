class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end
    
  def matches?(req)
    @default || (!req.headers['Accept'].nil? && req.headers['Accept'].include?("application/vnd.pushar.v#{@version}"))
  end
end
