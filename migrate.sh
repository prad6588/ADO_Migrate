set -ex
gh repo create angular --private
git clone --bare https://oauth2:$ADO_TOKEN@dev.azure.com/CDEDevOps/CDEDevOps_Assets/_git/AngularApp
cd AngularApp
git push --mirror https://github.com/prad6588/AngularApp
cd ..
rm -rf AngularApp
