require 'mechanize'

class CetesbGathererWorker
  include Sidekiq::Worker

  def perform(collector_id, platform_id)
    url_cetesb = "http://sistemasinter.cetesb.sp.gov.br/Ar/php/ar_resumo_hora.php"
    agent = Mechanize.new
    page = agent.get(url_cetesb)
    page.encoding = "utf-8"
    table = page.search("table tr td table.font01")[0]

    table.element_children.each do |line|
      next if line.element_children.empty?

      data = line.element_children

      region = data[0].text
      index= data[2].text
      polluting = data[3].text

      img = data[1].element_children[0].attributes["src"].value

      quality = 'boa' if img.include? "quadro1.gif"
      quality = 'moderada' if img.include? "quadro2.gif"
      quality = 'ruim' if img.include? "quadro3.gif"
      quality = 'muito ruim' if img.include? "quadro4.gif"
      quality = 'péssima' if img.include? "quadro5.gif"

      timestamp = Time.now.getutc.to_s

      doc = {
        region: region,
        quality: quality,
        index: index,
        polluting: polluting,
        timestamp: timestamp
      }

      resource = AirQuality.find_by(worker: AirQuality.workers[:cetesb_gatherer_worker], worker_uuid: doc[:region], platform_id: platform_id)
      if resource
        new_data = {
          air_quality: [{value: doc[:quality], timestamp: doc[:timestamp]}],
          polluting: [{value: doc[:polluting], timestamp: doc[:timestamp]}],
          polluting_index: [{value: doc[:polluting_index], timestamp: doc[:timestamp]}]
        }

        resource.send_data(new_data)
      else
        resource_data = {
          worker: AirQuality.workers[:cetesb_gatherer_worker],
          worker_uuid: doc[:region],
          lat: -23.559616, # TODO: fakedata
          lon: -1.55, # TODO: fakedata
          status: "active",
          region: doc[:region],
          platform_id: platform_id
        }
        res = AirQuality.create(resource_data)
        res.fetch_or_register
      end
    end
  end
end
