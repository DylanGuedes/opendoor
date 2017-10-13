class Collector
  attr_acessor :resource
  @resource = []

  def collect()
    @resource.each do |resource|
      # Uses generic method to feed data from source
      resource.extract_data
    end
  end
end
