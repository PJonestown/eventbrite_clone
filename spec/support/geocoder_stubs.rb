module GeocoderStubs
  Geocoder.configure(:lookup => :test)

  Geocoder::Lookup::Test.add_stub(
    'New York', [
      {
        'location'     => 'New York',
        'latitude'     => 40.7143528,
        'longitude'    => -74.0059731
      }
    ]
  )

  Geocoder::Lookup::Test.add_stub(

    'Chicago', [
      {
        'location'    => 'Chicago',
        'latitude'    => 41.8781136,
        'longitude'   => -87.6297982
      }
    ]
  )

  Geocoder::Lookup::Test.add_stub(

    'hssghdsfjghafh', [
      {
        'location'    => nil,
        'latitude'    => nil,
        'longitude'   => nil
      }
    ]
  )

  Geocoder::Lookup::Test.add_stub(

    '06804', [
      {
        'location'    => '06804',
        'city'        => 'Brookfield',
        'latitude'    => 41.466090,
        'longitude'   => -73.4062342
      }
    ]
  )
end
