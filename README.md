# WorldScope — Global Location Intelligence

WorldScope is a responsive dark-themed global map explorer prepared for the AWS Builder Center **Weekend Challenge: Map it**.

## Current application

The public entry point is `index.html` at the repository root. It uses MapLibre GL JS to render an Amazon Location Service basemap and provides:
- A USGS GeoJSON feed of earthquakes from the past seven days.
- A curated starter set of 20 global cities and landmarks.
- Search, layer toggles, map navigation and detail panels.
- Coordinate-based weather and air-quality forecasts from Open-Meteo.

**Important:** The map needs an Amazon Location Service API key before it can display. The repository contains only a placeholder configuration; no AWS credentials are committed. The website is not deployed just by creating this repository.

## Configure the AWS map

1. In AWS Console, open Amazon Location Service in a supported region (the sample uses `ap-south-1`).
2. Create a map resource (sample style: `Standard`).
3. Create a map API key with only the permissions needed for map rendering. Restrict its allowed origins where supported.
4. Copy `config.example.js` to `config.js` and replace the placeholder with your key.
5. Do not commit `config.js`. It is excluded by `.gitignore`.

The map style endpoint is:
`https://maps.geo.{region}.amazonaws.com/v2/styles/{style}/descriptor?key={apiKey}&color-scheme=Dark`

## Run locally

Serve the repository root over HTTP (do not open the HTML as a `file://` URL):

```bash
python -m http.server 8080
```

Open http://localhost:8080.

## Deploy to Amazon S3

Create a globally unique bucket and configure static website hosting. For a production-quality HTTPS site, keep the bucket private and use CloudFront with Origin Access Control. Review AWS's current S3 website hosting and public-access guidance before changing bucket permissions.

Example after AWS CLI credentials are configured and `config.js` is present locally:

```bash
BUCKET=your-unique-bucket-name REGION=ap-south-1 bash aws/s3-deploy.sh
```

The script syncs the root application while excluding the example config, repository metadata and documentation. Configure bucket access deliberately; do not make unrelated objects public.

## Dataset and mapping approach

- **USGS ComCat all-earthquakes past-7-days GeoJSON feed:** event coordinates, magnitude, depth, timestamp, place description and event URL. The app refreshes this feed every five minutes.
- **WorldScope curated places GeoJSON:** a starter set of 20 selected cities and landmarks with names, countries, categories and coordinates. The reusable dataset is in `site/data/places.geojson`; the demo currently embeds the same small starter set in its page for simple static hosting.
- **Open-Meteo weather and air-quality APIs:** coordinate-based current forecast values. These are model-based values, not direct physical monitoring-station readings.

MapLibre GL JS displays the GeoJSON point data. Place markers are clustered at lower zoom levels and earthquake markers are sized by magnitude. Users can select a map coordinate to request forecast context.

## AWS services

- **Amazon Location Service:** supplies the global basemap through its Maps API.
- **Amazon S3:** intended hosting and storage destination for the static application and GeoJSON data.

## Limitations and responsible use

The curated places list is not an exhaustive world gazetteer. Weather and air-quality values are model forecasts for selected coordinates and may not represent a nearby sensor. This is an educational explorer, not an emergency alert or health-decision system. Check provider terms, attribution and usage limits before public or commercial use.

## Before submitting to Builder Center

- [ ] Configure a restricted Amazon Location API key and verify that map tiles load.
- [ ] Deploy the app and test the public URL in a signed-out/incognito browser.
- [ ] Test earthquake feed, search, place markers, layer toggles and forecast lookup.
- [ ] Confirm no real credentials are committed.
- [ ] Record a public demo video under 3 minutes showing the live map and what viewers can explore.
- [ ] Include the dataset, mapping method, AWS services, live app URL, repository URL and demo video URL in the project entry.

## Sources

- USGS ComCat GeoJSON: https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php
- USGS all-week feed: https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson
- Open-Meteo Weather API: https://open-meteo.com/en/docs
- Open-Meteo Air Quality API: https://open-meteo.com/en/docs/air-quality-api
- Amazon Location Service: https://docs.aws.amazon.com/location/latest/developerguide/first-app.html

## Suggested demo video (about 2:20)

1. Introduce the problem and WorldScope.
2. Show the AWS-powered global basemap and zoom across continents.
3. Toggle earthquakes and inspect an event's magnitude, depth, time and USGS link.
4. Search a city or landmark and inspect its coordinates.
5. Select a coordinate and fetch weather and air-quality forecast context.
6. Explain the USGS/Open-Meteo datasets, Amazon Location Service map and planned S3 hosting.
