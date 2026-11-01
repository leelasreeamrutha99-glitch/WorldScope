# Builder Center submission draft

## Project title
WorldScope — Global Location Intelligence Explorer

## Short description
WorldScope turns location data into an explorable global picture. It combines USGS earthquake events, curated city and landmark locations, and coordinate-based weather and air-quality forecasts in one interactive map. Users can search places, zoom and pan across the world, explore clustered markers, inspect earthquake magnitude/depth/time, and request forecast context for any selected coordinate.

## Dataset and contents
- **USGS ComCat GeoJSON summary feed (all earthquakes, past 7 days):** point coordinates, event magnitude, depth, time, place description and event URL. This is a live public feed refreshed by the application every five minutes; USGS says its short-window feeds update frequently.
- **WorldScope curated places GeoJSON:** 20 selected global cities and landmarks with names, country, category, coordinates and a short descriptive note. This starter dataset is included in `site/data/places.geojson` and can be expanded with additional licensed/open geospatial data.
- **Open-Meteo weather and air-quality APIs:** coordinate-based current-condition forecast values such as temperature, humidity, wind, PM2.5 and AQI. These are model-based forecasts, not direct sensor observations.

## How the data is put on the map
The app reads GeoJSON point features and renders them with MapLibre GL JS. Place points are clustered at low zoom levels; earthquakes are drawn as magnitude-scaled circles. Clicking a point opens a detail panel. Selecting any coordinate allows the user to fetch weather and air-quality context for that location.

## AWS services and why
- **Amazon Location Service:** provides the global basemap and map style through the Maps API. MapLibre GL JS renders the AWS map tiles and supports interactive navigation and overlays.
- **Amazon S3:** hosts the static web application and the GeoJSON places dataset, making the app and data available from a public URL. For production-grade HTTPS delivery, S3 can be kept private behind CloudFront.

## Links to add before submission
- Live map: [PASTE YOUR DEPLOYED HTTPS URL]
- Public source repository: https://github.com/leelasreeamrutha99-glitch/WorldScope
- Public demo video (under 3 minutes): [PASTE YOUR PUBLIC VIDEO URL]

## Important project limitations
The included places file is a curated starter set, not an exhaustive gazetteer. Weather and air-quality outputs are forecasts at the selected coordinate and are not guaranteed to correspond to a nearby physical monitoring station. WorldScope is an exploratory educational tool and not an emergency-response or health-advice system.
