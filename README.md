# WorldScope — Global Location Intelligence

A responsive dark-themed global map explorer for the AWS Builder Center **Weekend Challenge: Map it**. It combines a real-time earthquake GeoJSON feed, a curated GeoJSON places dataset, and coordinate-based weather/air-quality forecasts in one interactive interface.

## What is included

- **Amazon Location Service** map tiles and map style, rendered with MapLibre GL JS.
- **Amazon S3** hosting for the static application and its GeoJSON dataset.
- **USGS earthquake feed** (all earthquakes, past 7 days; feed updates about every minute): https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson
- **Open-Meteo forecast APIs** for weather and air quality at a user-selected coordinate. These are model-based forecast/current-condition values, not direct station observations.
- **Curated global cities and landmarks** in `site/data/places.geojson`, with names, countries, categories, coordinates and short descriptions.
- Search, layer toggles, clustered place markers, event details, responsive layout and location lookup.

## 1. Configure Amazon Location Service

1. In the AWS Console, open **Amazon Location Service** in a supported region (the starter config uses `ap-south-1`).
2. Create a map resource using a supported style (the app defaults to `Standard`).
3. Create an API key with map read permissions for that map. Restrict the key to the minimum required operations and allowed origins where available. Do not use an unrestricted production key.
4. Copy `site/config.example.js` to `site/config.js` and set `amazonLocationApiKey` to the key value. Keep `config.js` out of the public Git repository (it is ignored by `.gitignore`).
5. If you choose another AWS region or map style, update `awsRegion` and `mapStyle` in `config.js` to match your resource.

The map style URL follows AWS's MapLibre integration pattern:
`https://maps.geo.{region}.amazonaws.com/v2/styles/{style}/descriptor?key={apiKey}&color-scheme=Dark`

## 2. Run locally

The project is static. From the `site` directory, start a local HTTP server (do not open `index.html` as a `file://` URL):

```bash
cd site
python -m http.server 8080
```

Open http://localhost:8080. Configure the AWS key first or the map will display a setup message. The browser must have internet access to load MapLibre, AWS map tiles and the public data APIs.

## 3. Deploy to Amazon S3

Create a unique S3 bucket in your preferred region. For a quick public demo, configure static website hosting and public read access for the site objects. For a safer production setup, keep the bucket private and serve it through CloudFront with Origin Access Control. Do not put credentials or private data in the bucket.

Example commands (replace the bucket name):

```bash
aws s3 mb s3://YOUR-UNIQUE-WORLDSCOPE-BUCKET --region ap-south-1
aws s3 website s3://YOUR-UNIQUE-WORLDSCOPE-BUCKET/ --index-document index.html
aws s3 sync ./site s3://YOUR-UNIQUE-WORLDSCOPE-BUCKET/ --delete --exclude 'config.example.js'
```

For the simple public-website option, configure the bucket's Block Public Access and bucket policy deliberately, following AWS's current S3 static website hosting guide. S3 website endpoints are HTTP; use CloudFront for HTTPS and a stronger public deployment. If using CloudFront, set the default root object to `index.html` and invalidate after updates.

## 4. Dataset and service explanation for the challenge

**Dataset started with:** USGS ComCat all-earthquakes past-7-days GeoJSON feed. Each feature includes coordinates, magnitude, depth, event time, place label and an event URL. The app also includes a small curated GeoJSON file of global cities and landmarks for searchable place context.

**How it is mapped:** GeoJSON point geometries are rendered with clustered city/landmark points and magnitude-scaled earthquake circles. Clicking an earthquake opens its USGS event details. Clicking any map coordinate enables a weather and air-quality forecast lookup for that point.

**AWS services and why:** Amazon Location Service supplies the global basemap through its Maps API and map style. Amazon S3 stores and serves the static app and its GeoJSON data file, making the project easy to publish and reuse.

**Limitations:** The curated city/landmark list is a starter dataset, not a complete world gazetteer. Weather and air-quality values are model forecasts for the selected coordinates; they should not be presented as sensor readings. This is an educational explorer, not an emergency alert or health decision system.

## 5. Before submitting

- [ ] Add a restricted Amazon Location API key and verify map tiles load.
- [ ] Deploy the app and test the public URL in an incognito window.
- [ ] Check earthquake feed, search, place markers, layer toggles and forecast lookup.
- [ ] Confirm your public GitHub repository excludes `site/config.js` and any real credentials.
- [ ] Record a public demo video under 3 minutes showing the live map and what viewers can explore.
- [ ] In the Builder Center project write-up, name the datasets, explain the Amazon Location Service and S3 architecture, and include the live map URL and demo-video URL.

## Data sources and attribution

- USGS Earthquake Hazards Program, ComCat GeoJSON summary feed: https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php
- Open-Meteo Weather API: https://open-meteo.com/en/docs
- Open-Meteo Air Quality API: https://open-meteo.com/en/docs/air-quality-api
- Amazon Location Service developer guide: https://docs.aws.amazon.com/location/latest/developerguide/first-app.html

Check each provider's current terms, attribution requirements and usage limits before public/commercial use.

## Suggested short demo flow (2:20)

1. (0:00–0:20) Introduce WorldScope and the problem: location data is hard to understand in separate dashboards.
2. (0:20–0:50) Show the AWS-powered global basemap and zoom across continents.
3. (0:50–1:20) Toggle earthquake data; click an event and show magnitude, depth, time and the USGS event link.
4. (1:20–1:45) Search for a city or landmark; show clustered markers and the curated places profile.
5. (1:45–2:05) Click a coordinate and fetch weather and air-quality forecast context.
6. (2:05–2:20) Explain the data pipeline: USGS/Open-Meteo + GeoJSON, Amazon Location Service for maps, Amazon S3 for hosting/data. End with the live URL and GitHub repo.
