module InterscityResource
  extend ActiveSupport::Concern

  included do
    enum steps: [:not_registered, :registered]
    enum workers: [:cetesb_gatherer_worker, :citybik_gatherer_worker,
      :catracalivre_gatherer_worker]
  end

  def normalized_registration_data
    raise "You should override #normalized_registration_data"
  end

  def fetch_from_platform
    if not self.uuid
      raise "Resource from #{self.worker_uuid} doesn't have an uuid."
    end

    platform_url = self.platform.url
    url = platform_url + "/catalog/resources/#{self.uuid}"
    RestClient.get(url)
  end

  def ensure_capabilities_exist(platform_url, capabilities)
    url = platform_url + '/catalog/capabilities'
    capabilities.each do |x|
      data = {
        name: x[:title],
        capability_type: x[:typ],
        description: x[:description]
      }
      begin
        response = RestClient.post(url, data)
        response = JSON.parse(response)
        puts "Capability #{x[:title]} registered with id #{response["id"]}".green
      rescue RestClient::Exception => e
        puts "ERROR: Could not register capability #{x[:title]}. Maybe the name is already being used?".red
      end
    end
  end

  def fetch_or_register
    if not self.platform
      raise 'Resource without a platform.'
    end

    platform_url = self.platform.url
    url = platform_url + "/adaptor/components"

    doc = normalized_registration_data
    ensure_capabilities_exist(platform_url, self.class.capabilities)

    if self.uuid.blank? or not fetch_from_platform
      begin
        response = RestClient.post(url, {data: doc})
        response = JSON.parse(response)
        self.uuid = response["data"]["uuid"]
        self.save
        puts "Resource #{self.uuid} #{'registered'.green}"
      rescue RestClient::Exception => e
        puts "ERROR: Could not register resource. Description: #{e}".red
      end
    else
      puts "Resource #{self.uuid} #{' already registered'.green}"
    end
  end

  def send_data(new_data)
    if self.platform
      url = self.platform.url + "/adaptor/components/#{self.uuid}/data"
      begin
        puts "Updating data: #{new_data}"
        response = RestClient.post(url, new_data)
        puts "Resource #{self.uuid} #{'updated'.blue}"
      rescue RestClient::Exception => e
        puts "ERROR: Could not send data from resource. Description: #{e.response}".red
      end
    else
      raise 'Resource #{self.uuid} without a platform.'
    end
  end
end
