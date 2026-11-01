# WorldScope — Global Location Intelligence

WorldScope is a responsive dark-themed global map explorer prepared for the AWS Builder Center **Weekend Challenge: Map it**.

## Current application

The public entry point is `index.html` at the repository root. It uses MapLibre GL JS with OpenStreetMap raster tiles and provides:
- A USGS GeoJSON feed of earthquakes from the past seven days.
- A curated starter set of 20 global cities and landmarks.
- Search, layer toggles, map navigation and detail panels.
- Coordinate-based weather and air-quality forecast context from Open-Meteo.

**No map API key is required.** The map uses the standard OpenStreetMap tile service. Keep usage light and follow the tile usage policy; do not bulk-download tiles or use this public service for heavy production traffic.

## Run locally

Serve the repository root over HTTP (do not open the HTML as a `file://` URL):

```bash
python -m http.server 8080
```

Open http://localhost:8080.

## Map and tile attribution

The basemap is provided by OpenStreetMap contributors and rendered by MapLibre GL JS. The map includes visible attribution. OpenStreetMap's standard tile service is community infrastructure with a usage policy: https://operations.osmfoundation.org/policies/tiles/

For larger production usage, select a tile provider whose terms and capacity fit your application, or operate your own tile service.

## Deploy to Amazon S3

Amazon S3 can host the static website and store the GeoJSON dataset. Create a globally unique bucket and configure static website hosting. For a production-quality HTTPS site, use CloudFront in front of a private S3 bucket with Origin Access Control. Review AWS's current S3 website hosting and public-access guidance before changing bucket permissions.

Example after AWS CLI credentials are configured:

```bash
BUCKET=your-unique-bucket-name REGION=ap-south-1 bash aws/s3-deploy.sh
```

Configure bucket access deliberately; do not make unrelated objects public. The repository itself is not automatically deployed to S3.

## Dataset and mapping approach

- **USGS ComCat all-earthquakes past-7-days GeoJSON feed:** event coordinates, magnitude, depth, timestamp, place description and event URL. The app refreshes this feed every five minutes.
- **WorldScope curated places GeoJSON:** a starter set of 20 selected cities and landmarks with names, countries, categories and coordinates. The reusable dataset is in `site/data/places.geojson`; the demo embeds the same small starter set in its page for simple static hosting.
- **Open-Meteo weather and air-quality APIs:** coordinate-based current forecast values. These are model-based values, not direct physical monitoring-station readings.

MapLibre GL JS displays the GeoJSON point data. Place markers are clustered at lower zoom levels and earthquake markers are sized by magnitude. Users can select a map coordinate to request forecast context.

## AWS services

- **Amazon S3:** planned hosting destination for the static application and GeoJSON data. This service is not yet deployed/configured in this repository.
- **OpenStreetMap:** basemap tiles.
- **MapLibre GL JS:** map rendering and interaction.

This version no longer requires Amazon Location Service credentials. If the challenge requires a specific AWS location service, confirm that OpenStreetMap plus S3 meets the judging requirements before submitting.

## Limitations and responsible use

The curated places list is not an exhaustive world gazetteer. Weather and air-quality values are forecasts for selected coordinates and may not represent a nearby sensor. This is an educational explorer, not an emergency alert or health-decision system.

## Before submitting to Builder Center

- [ ] Run the app locally and verify the basemap tiles load.
- [ ] Test earthquake feed, search, place markers, layer toggles and forecast lookup.
- [ ] Deploy the app to S3 (or another approved host) and test the public URL in a signed-out/incognito browser.
- [ ] Confirm no credentials are committed.
- [ ] Record a public demo video under 3 minutes showing the working map.
- [ ] Include the dataset, mapping method, AWS services, live app URL, repository URL and demo video URL in the project entry.

## Sources

- OpenStreetMap tile usage policy: https://operations.osmfoundation.org/policies/tiles/
- USGS ComCat GeoJSON: https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php
- USGS all-week feed: https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson
- Open-Meteo Weather API: https://open-meteo.com/en/docs
- Open-Meteo Air Quality API: https://open-meteo.com/en/docs/air-quality-api
- MapLibre GL JS: https://maplibre.org/maplibre-gl-js/docs/
