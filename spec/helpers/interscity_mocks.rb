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
end
