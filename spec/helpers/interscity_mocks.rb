module InterscityMocks
  def soft_stub_capabilities
    capabilities_url = "http://localhost:8000/catalog/capabilities"
    body = {}.to_json

    stub_request(:post, capabilities_url).
      with{|request| not request.body.blank? and not request.headers.blank?}.
      to_return(status: 200, body: body, headers: {})
  end

  def soft_stub_resource_registration(uuid)
    registration_url = "http://localhost:8000/adaptor/components"
    body = {data: {uuid: uuid} }.to_json

    stub_request(:post, registration_url).
      with{|request| not request.body.blank? and not request.headers.blank?}.
      to_return(status: 200, body: body, headers: {})
  end

  def soft_stub_resource_data_sending(uuid)
    r = {}.to_json
    send_data_url = "http://localhost:8000/adaptor/components/#{uuid}/data"
    stub_request(:post, send_data_url).
      with{|request| not request.headers.blank?}.
      to_return(status: 200, body: r, headers: {})
  end

  def soft_stub_specific_capability(capability)
    capabilities_url = "http://localhost:8000/catalog/capabilities"
    stub_request(:post, capabilities_url).
      with{|request| request.body==capability and not request.headers.blank?}.
      to_return(status: 200, body: {}.to_json, headers: {})
  end

  def soft_stub_resource
    resource_url = "http://localhost:8000/catalog/resources"
    body = {data: {uuid: uuid} }.to_json

    stub_request(:get, resource_url).
      with{|request| not request.headers.blank?}.
      to_return(status: 200, body: body, headers: {})
  end

  def soft_stub_resource_data(uuid)
    resource_url = "http://localhost:8000/catalog/resources/#{uuid}"
    body = {data: {uuid: uuid} }.to_json

    stub_request(:get, resource_url).
      with{|request| not request.headers.blank?}.
      to_return(status: 200, body: body, headers: {})
  end

  def accuweather_index_stub
    agent = Mechanize.new
    data = agent.get("file:///#{Dir.pwd}/accuweather_index")

    stub_request(:get, "http://www.accuweather.com/pt/br/brazil-weather").
      with{|request| not request.headers.blank?}.
      to_return(status: 200, body: data.body, headers: {
      'Content-Type': 'text/html'
    })
  end

  def stub_accuweather_posts
    agent = Mechanize.new

    data = agent.get("file:///#{Dir.pwd}/accuweather_anhanguera_page")
    stub_request(:post, "https://www.accuweather.com/pt/search-locations").
      with{|request| not request.headers.blank?}.
      to_return(status: 200, body: data.body, headers: {'Content-Type': 'text/html'})

    # url = "https://www.accuweather.com/pt/br/anhanguera/2310876/weather-forecast/2310876"
    # data = agent.get("file:///#{Dir.pwd}/accuweather_anhanguera_page")
    # stub_request(:get, url).
    #   with{|request| not request.headers.blank?}.
    #   to_return(status: 200, body: data.body, headers: {'Content-Type': 'text/html'})

    data = agent.get("file:///#{Dir.pwd}/accuweather_temperature_click")

    current_weather_urls = [
      "https://www.accuweather.com/pt/us/new-york-ny/10007/current-weather/349727",
      "https://www.accuweather.com/pt/br/anhanguera/2310876/current-weather/2310876"
    ]

    current_weather_urls.each do |url|
      stub_request(:get, url).
        with{|request| not request.headers.blank?}.
        to_return(status: 200, body: data.body, headers: {'Content-Type': 'text/html'})
    end
  end
end
