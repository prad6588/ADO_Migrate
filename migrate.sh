set -x
jq -c '.github_migration[]' "github_migration.json" | while read -r application; do
            Destination_Reponame=$(echo "$application" | jq -r '.Destination_Reponame')
            Source_Repo=$(echo "$application" | jq -r '.Source_Repo')
            Team_Permission=$(echo "$application" | jq -r '.Team_Permission')
            Owner=$(echo "$application" | jq -r '.Owner')

            echo "Destination_Reponame $Destination_Reponame"
            echo "Source_Repo $Source_Repo"
            echo "Team_Permission $Team_Permission"
            echo "Owner $Owner"    
        
  
        done
        
gh repo create AngularApp --private
git clone --bare https://oauth2:$ADO_TOKEN@dev.azure.com/CDEDevOps/CDEDevOps_Assets/_git/AngularApp || echo "Repo exists"
cd AngularApp.git
git push --mirror https://prad6588:$GITHUB_TOKEN@github.com/prad6588/AngularApp.git
cd ..
rm -rf AngularApp.git
git remote add origin https://prad6588:$GITHUB_TOKEN@github.com/prad6588/AngularApp.git
git remote set-url origin https://prad6588:$GITHUB_TOKEN@github.com/prad6588/AngularApp.git
curl -L -X PUT -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/prad6588/AngularApp/collaborators/ravindranathbarathy -d '{"permission":"triage"}'
curl -L -X PUT -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/prad6588/AngularApp/branches/master/protection -d '{"required_status_checks":{"strict":true,"contexts":["continuous-integration/travis-ci"]},"enforce_admins":true,"required_pull_request_reviews":{"dismissal_restrictions":{"users":["octocat"],"teams":["justice-league"]},"dismiss_stale_reviews":true,"require_code_owner_reviews":true,"required_approving_review_count":2,"require_last_push_approval":true,"bypass_pull_request_allowances":{"users":["octocat"],"teams":["justice-league"]}},"restrictions":{"users":["octocat"],"teams":["justice-league"],"apps":["super-ci"]},"required_linear_history":true,"allow_force_pushes":true,"allow_deletions":true,"block_creations":true,"required_conversation_resolution":true,"lock_branch":true,"allow_fork_syncing":true}'
