#####################################################
#    C O N F I G U R A T I O N    (to modify)
#####################################################

# Import configurations from config.txt
while IFS="=" read -r key value
do
    declare "$key=$value"
done < config.txt
