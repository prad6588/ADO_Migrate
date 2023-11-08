Orgname=pradeep6588
accountname=prad6588
Sourcerepourl=dev.azure.com/CDEDevOps/CDEDevOps_Assets/_git

set -x
jq -c '.github_migration[]' "github_migration.json" | while read -r application; do
            Destination_Reponame=$(echo "$application" | jq -r '.Source_Repo_name')
            Team_Permission=$(echo "$application" | jq -r '.Team_Permission')
            Owner=$(echo "$application" | jq -r '.Owner')

            echo "Destination_Reponame $Destination_Reponame"
            echo "Team_Permission $Team_Permission"
            echo "Owner $Owner"    

gh extension install github/gh-ado2gh
gh extension upgrade github/gh-ado2gh
export GH_PAT="$GITHUB_TOKEN"
export ADO_PAT="$ADO_TOKEN"

gh ado2gh migrate-repo --ado-org CDEDevOps --ado-team-project CDEDevOps_Assets --ado-repo $Destination_Reponame --github-org $Orgname --github-repo $Destination_Reponame

# gh repo create $Orgname/$Destination_Reponame --private
# git clone --bare https://oauth2:$ADO_TOKEN@$Sourcerepourl/$Destination_Reponame || echo "Repo exists"
# cd $Destination_Reponame.git
# git push --mirror https://$accountname:$GITHUB_TOKEN@github.com/$Orgname/$Destination_Reponame.git
# cd ..
# rm -rf $Destination_Reponame.git
git remote add origin https://$accountname:$GITHUB_TOKEN@github.com/$Orgname/$Destination_Reponame.git
git remote set-url origin https://$accountname:$GITHUB_TOKEN@github.com/$Orgname/$Destination_Reponame.git
curl -L -X PUT -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/$Orgname/$Destination_Reponame/collaborators/$Team_Permission -d '{"permission":"triage"}'
curl -L -X PUT -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/$Orgname/$Destination_Reponame/branches/master/protection -d '{"required_status_checks":{"strict":true,"contexts":["continuous-integration/travis-ci"]},"enforce_admins":true,"required_pull_request_reviews":{"dismissal_restrictions":{"users":["octocat"],"teams":["justice-league"]},"dismiss_stale_reviews":true,"require_code_owner_reviews":true,"required_approving_review_count":2,"require_last_push_approval":true,"bypass_pull_request_allowances":{"users":["octocat"],"teams":["justice-league"]}},"restrictions":{"users":["octocat"],"teams":["justice-league"],"apps":["super-ci"]},"required_linear_history":true,"allow_force_pushes":true,"allow_deletions":true,"block_creations":true,"required_conversation_resolution":true,"lock_branch":true,"allow_fork_syncing":true}'        
  
        done
        
