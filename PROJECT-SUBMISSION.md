# Builder Center submission draft

## Project title
WorldScope — Global Location Intelligence Explorer

## Short description
WorldScope turns location data into an explorable global picture. It combines USGS earthquake events, curated city and landmark locations, and coordinate-based weather and air-quality forecast context in one interactive map. Users can search places, zoom and pan across the world, explore clustered markers, inspect earthquake magnitude/depth/time, and request forecast context for any selected coordinate.

## Dataset and contents
- **USGS ComCat GeoJSON summary feed (all earthquakes, past 7 days):** point coordinates, event magnitude, depth, time, place description and event URL. This is a live public feed refreshed by the application every five minutes.
- **WorldScope curated places GeoJSON:** 20 selected global cities and landmarks with names, country, category and coordinates. This starter dataset is included in `site/data/places.geojson`.
- **Open-Meteo weather and air-quality APIs:** coordinate-based forecast context such as temperature, humidity, wind, PM2.5 and AQI. These are model-based forecast values, not direct sensor observations.

## How the data is put on the map
The app reads GeoJSON point data and renders it with MapLibre GL JS over OpenStreetMap raster tiles. Place points are clustered at low zoom levels; earthquakes are drawn as magnitude-scaled circles. Clicking a point opens a detail panel. Selecting any coordinate allows the user to fetch weather and air-quality context for that location. OpenStreetMap attribution is displayed on the map.

## AWS services and why
- **Amazon S3 (planned):** intended to host the static web application and store the GeoJSON places dataset. This deployment is not yet completed.
- **OpenStreetMap:** supplies the basemap tiles.
- **MapLibre GL JS:** renders the map and interactive overlays.

This version does not currently use Amazon Location Service. Confirm the challenge's AWS location/data-service requirement accepts the combination of S3 and OpenStreetMap before submitting.

## Links to add before submission
- Live map: [PASTE YOUR DEPLOYED HTTPS URL]
- Public source repository: https://github.com/leelasreeamrutha99-glitch/WorldScope
- Public demo video (under 3 minutes): [PASTE YOUR PUBLIC VIDEO URL]

## Important project limitations
The included places file is a curated starter set, not an exhaustive gazetteer. Weather and air-quality outputs are forecasts at the selected coordinate and are not guaranteed to correspond to a nearby physical monitoring station. WorldScope is an exploratory educational tool and not an emergency-response or health-advice system.
