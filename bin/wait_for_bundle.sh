#!/usr/bin/env bash

set -eu

has_bundle() {
  has_bundle=1
  if [ -f "out/bundle.js" ]; then has_bundle=0; fi;
  return $has_bundle;
}

while ! has_bundle
do
    echo "Waiting for webpack bundle to finish building..."
    ((c++)) && ((c==10)) && break
    sleep 1
done

if [ ! has_bundle ]; then
  echo "Bundle was not built within the time limit :(";
  exit 1;
else
  echo "Webpack bundle built successfully!"
fi;

echo -e "\nStarting the application... press CTRL+C to exit the process"
node out/bundle.js
