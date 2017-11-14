class WifiStationGathererWorker
  include Sidekiq::Worker

  @@cron_scheduled = false

  # Fetch static entities from shape files and inject in an instance of the
  # platform.
  def perform(platform_id, path)
    RGeo::Shapefile::Reader.open(path) do |file|
      file.each do |record|
        attrs = record.attributes
        name = attrs[FreeWifiStation.identifier_attr]

        if not name
          next
        end

        x_y_coords = record.geometry.coordinates
        record_data = {
          coordinates: x_y_coords,
          name: name,
          platform_id: platform_id,
          lat: x_y_coords[0],
          lon: x_y_coords[1]
        }

        resource = FreeWifiStation.find_by(platform_id: platform_id, worker_uuid: name)

        if not platform_id or not name
          raise 'INVALID ATTRIBUTES!!'
        end

        if not resource or not resource.uuid
          data = FreeWifiStation.mount_resource(record_data)
          resource = FreeWifiStation.create(data)
          puts resource.inspect
          resource.fetch_or_register
          resource.update_location
        else
          puts "DIDNT REGISTERED RESOURCE #{resource.uuid}"
        end
      end
    end
  end
end
