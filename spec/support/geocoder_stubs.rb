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

    '72.229.28.185', [
      {
        'latitude'      => 40.732,
        'longitude'     => -73.989,
        'city'          => 'New York',
        'country_code'  => 'US'
      }
    ]
  )


end
