set -ex
cat github_migration.json | json_pp


jq -c '.github_migration[]' "github_migration.json" | while read -r application; do
            Destination_Reponame=$(echo "$application" | jq -r '.Source_Repo_name')
            Team_Permission=$(echo "$application" | jq -r '.Team_Permission')
            Owner=$(echo "$application" | jq -r '.Owner')

            echo "Destination_Reponame $Destination_Reponame"
            echo "Team_Permission $Team_Permission"
            echo "Owner $Owner"    
done
