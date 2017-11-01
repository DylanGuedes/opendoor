class InitiativeRegistrationWorker
  include Sidekiq::Worker

  def perform(body, platform_id)
    timestamp = DateTime.now.to_s

    attrs = {
      worker_uuid: body[:name],
      platform_id: platform_id
    }
    # if the resource is already present, do not register a new one
    resource = Initiative.find_by(attrs)

    if resource and resource.uuid
      new_data = {}
      new_data[:responsible] = [
        {
          responsible: body[:responsible],
          responsible_phone: body[:responsible_phone],
          responsible_email: body[:resposible_email],
          timestamp: timestamp
        }
      ]
      update_resource_data(resource, {data: new_data})
    else
      create_resource(body, platform_id)
    end
  end

  def update_resource_data(resource, new_data)
    resource.send_data(new_data)
  end

  def create_resource(initiative, platform_id)
    coords = Geocoder.coordinates("#{initiative[:region]} #{initiative[:city]}")
    unless coords
      coords = Geocoder.coordinates("São Paulo") # if region isnt available..
    end

    resource_data = {
      worker_uuid: initiative[:name],
      lat: coords[0],
      lon: coords[1],
      status: "active",
      region: "#{initiative[:region]} #{initiative[:city]}",
      platform_id: platform_id
    }
    res = Initiative.create(resource_data)
    res.fetch_or_register
  end
end
