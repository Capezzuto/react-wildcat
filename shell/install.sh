#!/bin/bash

set -u

example=example
version=$(<VERSION)

# Set up links
for directory in packages/*; do
    if [ -d "${directory}" ]; then
        package=${directory##*/}

        if [ -f "${directory}/package.json" ]; then
            # Create module / package links
            (
                cd ${directory};

                # react-wildcat-handoff depends on react-wildcat-radium
                if [ "${package}" == "react-wildcat-handoff" ]; then
                    npm link "react-wildcat-radium";
                fi

                # Link package to npm
                npm link;

                # Link package to jspm
                jspm link npm:${package}@${version} --log warn -y;
            )
        fi
    fi
done
