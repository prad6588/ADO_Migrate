set -x
gh repo create AngularApp --private
git clone --bare https://oauth2:$ADO_TOKEN@dev.azure.com/CDEDevOps/CDEDevOps_Assets/_git/AngularApp || echo "Repo exists"
cd AngularApp.git
git remote set-url origin https://prad6588:$GITHUB_TOKEN@github.com/prad6588/AngularApp.git
ech0 $GITHUB_TOKEN
git push --mirror https://github.com/prad6588/AngularApp.git
cd ..
rm -rf AngularApp.git
