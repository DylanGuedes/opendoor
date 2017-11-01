class InitiativeRegistrationWorker
  include Sidekiq::Worker

  def perform(body, platform_id)
    timestamp = DateTime.now.to_s
    body = eval(body)

    attrs = {
      worker_uuid: body.fetch("name"),
      platform_id: platform_id
    }

    create_resource(body, platform_id)

    resource = Initiative.find_by(attrs)

    new_data = {}
    new_data[:responsible] = [
      {
        responsible: body.fetch("responsible"),
        responsible_phone: body.fetch("responsible_phone"),
        responsible_email: body.fetch("responsible_email"),
        timestamp: timestamp
      }
    ]
    update_resource_data(resource, {data: new_data})
  end

  def update_resource_data(resource, new_data)
    resource.send_data(new_data)
  end

  def create_resource(initiative, platform_id)
    coords = Geocoder.coordinates("#{initiative.fetch("address")} #{initiative.fetch("city")}")
    unless coords
      coords = Geocoder.coordinates("São Paulo") # if region isnt available..
    end

    resource_data = {
      worker: 1,
      worker_uuid: initiative.fetch("name"),
      lat: coords[0],
      lon: coords[1],
      status: "active",
      region: "#{initiative.fetch("address")} #{initiative.fetch("city")}",
      platform_id: platform_id,
      state: initiative.fetch("state")
    }
    res = Initiative.create(resource_data)
    res.fetch_or_register
  end
end
