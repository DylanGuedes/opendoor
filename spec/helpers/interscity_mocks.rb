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

  def soft_stub_catracalivre_request
    data =
    {
      responseHeader: {
        status: 0,
        QTime: 1,
        params: {
          q: "place_cidades.id:9668 AND post_publish_date:[NOW-5DAYS TO NOW]",
          wt: "json"
        }
      },
      response: {
        numFound: 18,
        start: 0,
        docs: [
          {
            post_id: 802141,
            post_title: "Catraca livre title",
            post_type: "event",
            post_publish_date: "2017-11-28T15:39:30Z",
            post_author: "author",
            post_content: "content",
            post_excerpt: "excerpt",
            post_image_thumbnail: "url thumbnail",
            post_image_full: "url full image",
            post_image_sizes: "[]",
            post_permalink: "permalink",
            post_sitecode: ["sp"],
            post_site_referrer: "{}",
            site_id: 9,
            id: "802141-9",
            place_name: [ "place name" ],
            place_city: [ "city name"  ],
            place_type: [ "Trem"       ],
            place_type_slug: [ "slug"  ],
            place_geolocation: ["-23.0,-46.0" ],
            place_neighborhood: [ "Neighbourhood" ],
            place_zone: [ "" ],
            place_mesoregion: [ "region" ],
            'place_paises.id': [  32       ],
            'place_estados.id': [ 53       ],
            'place_cidades.id': [  9668    ],
            'place_bairros.id': [  26312   ],
            'place_logradouros.id': [ 594313 ],
            event_place: [   ],
            event_agenda: [  ],
            event_agenda_slug: [  ],
            post_category: [  ],
            post_category_slug: [  ],
            post_tag: [ ],
            post_tag_slug: [ ],
            event_price: "Catraca Livre",
            event_datetime: [ "2017-12-03T12:00:00Z" ],
            event_time_human: [  "&agrave;s 12:00"   ],
            place_id: [ 314057 ]
          }
        ]
      }
    }.to_json

    url = "https://api.catracalivre.com.br/select/?q=place_cidades.id:9668"\
                  " AND post_publish_date:[NOW-5DAYS TO NOW]&wt=json"
    stub_request(:get, url).
      with{|request| not request.headers.blank?}.
      to_return(status: 200, body: data, headers: {'Content-Type': 'text/html'})
  end

  def soft_stub_citybik_request
    data = {
      network: {
        company: [
          "Mobilicidade Tecnologia LTD",
          "Grupo Serttel LTDA"
        ],
        href: "/v2/networks/bikesampa",
        id: "bikesampa",
        location: {
          city: "S\u00e3o Paulo",
          country: "BR",
          latitude: -23.55,
          longitude: -46.6333
        },
        name: "BikeSampa",
        stations: [
          {
            empty_slots: 12,
            extra: {
              address: "Rua Manoel de Nobrega 71",
              slots: 12,
              status: "open",
              uid: 15
            },
            free_bikes: 0,
            id: "38ae2324128bb287e9c0e65ff86bbe70",
            latitude: -23.568267,
            longitude: -46.649108,
            name: "Metr\u00f4 Brigadeiro",
            timestamp: "2017-11-14T17:15:33.947000Z"
          },
        ]
      }
    }.to_json

    url = "https://api.citybik.es/v2//networks/bikesampa"
      stub_request(:get, url).
        with{|request| not request.headers.blank?}.
        to_return(status: 200, body: data, headers: {'Content-Type': 'text/html'})
  end
end
