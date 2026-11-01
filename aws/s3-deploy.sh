#!/usr/bin/env bash
set -euo pipefail
: "${BUCKET:?Set BUCKET to your globally unique S3 bucket name}"
REGION="${REGION:-ap-south-1}"
aws s3 mb "s3://${BUCKET}" --region "${REGION}" || true
aws s3 website "s3://${BUCKET}" --index-document index.html
aws s3 sync ./site "s3://${BUCKET}/" --delete --exclude 'config.example.js'
echo "Uploaded WorldScope to s3://${BUCKET}/"
echo "Configure bucket access / CloudFront using the current AWS S3 static website guidance."
