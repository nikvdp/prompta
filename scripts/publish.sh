#!/bin/bash
#

##
## It is assumed this is run aver a verion tag. I.e. `npm run release && npm run gh:publish`
##

set -e 

# if gh is not installed, fail
if ! command -v gh &> /dev/null
then
    echo "gh could not be found"
    exit
fi

# run our build to generate the mac dmg. this also ensures the publish fails if the build fails
npm run build && git push && git push --tags

echo "Waiting for the release workflow to start..."
sleep 5

# TODO: watch is interactive, would be better to automate it to 'the most recent workflow'
gh run watch && ./scripts/upload.sh