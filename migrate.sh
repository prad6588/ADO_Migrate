set -x
gh repo create AngularApp --private
git clone --bare https://oauth2:$ADO_TOKEN@dev.azure.com/CDEDevOps/CDEDevOps_Assets/_git/AngularApp || echo "Repo exists"
cd AngularApp.git
git remote rm origin
git remote add origin 'git@github.com:prad6588/AngularApp.git'
git remote add origin https://prad6588:$GH_PAT@github.com/prad6588/AngularApp.git
git remote set-url origin https://prad6588:$GH_PAT@github.com/prad6588/AngularApp.git
git push --mirror https://prad6588:$GH_PAT@github.com/prad6588/AngularApp.git
cd ..
rm -rf AngularApp.git
