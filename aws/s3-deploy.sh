#!/usr/bin/env bash
set -euo pipefail
: "${BUCKET:?Set BUCKET to your globally unique S3 bucket name}"
REGION="${REGION:-ap-south-1}"
aws s3 mb "s3://${BUCKET}" --region "${REGION}" || true
aws s3 website "s3://${BUCKET}" --index-document index.html
aws s3 sync . "s3://${BUCKET}/" --delete --exclude '.git/*' --exclude '.gitignore' --exclude 'README.md' --exclude 'PROJECT-SUBMISSION.md' --exclude 'config.example.js' --exclude 'aws/*' --exclude 'site/*'
echo "Uploaded WorldScope to s3://${BUCKET}/"
echo "Configure bucket access deliberately; use CloudFront for HTTPS."
