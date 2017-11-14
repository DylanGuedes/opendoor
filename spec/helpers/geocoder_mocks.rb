module GeocoderMocks
  def stub_sao_paulo_coordinates(address="%20S%C3%A3o%20Paulo")
    r = {
      results: [{
        address_components: [
          {
            long_name: "São Paulo",
            short_name: "São Paulo",
            types: [ "locality", "political" ]
          },
          {
            long_name: "São Paulo",
            short_name: "São Paulo",
            types: [ "administrative_area_level_2", "political" ]
          },
          {
            long_name: "State of São Paulo",
            short_name: "SP",
            types: [ "administrative_area_level_1", "political" ]
          },
          {
            long_name: "Brazil",
            short_name: "BR",
            types: [ "country", "political" ]
          }
        ],
        formatted_address: "São Paulo, State of São Paulo, Brazil",
        geometry: {
          bounds: {
            northeast: {
              lat: -23.3566039,
              lng: -46.3650844
            },
            southwest: {
              lat: -24.0082209,
              lng: -46.825514
            }
          },
          location: {
            lat: -23.5505199,
            lng: -46.63330939999999
          },
          location_type: "APPROXIMATE",
          viewport: {
            northeast: {
              lat: -23.3566039,
              lng: -46.3650844
            },
            southwest: {
              lat: -24.0082209,
              lng: -46.825514
            }
          }
        },
        place_id: "ChIJ0WGkg4FEzpQRrlsz_whLqZs",
        types: [ "locality", "political" ]
      }
      ],
      status: "OK"
    }.to_json
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&language=en&sensor=false"
    stub_request(:get, url).
      with{|request| true}.
      to_return(status: 200, body: r, headers: {})
  end
end
