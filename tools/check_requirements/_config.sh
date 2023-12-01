# Import configurations from config.txt
while IFS="=" read -r key value || [ -n "$key" ]; do
    # Remove inline comments and trim whitespace
    key=$(echo "$key" | sed 's/\s*#.*//')
    value=$(echo "$value" | sed 's/\s*#.*//')

    # Skip empty lines
    if [[ -z $key ]]; then
        continue
    fi

    declare "$key=$value"
done < config.txt
