set -e
npm run build
cd resume/.vuepress/dist

git init
git add -A
git commit -m 'deploy'

git push -f https://github.com/Sirice19/Resume-vuepress.git master:gh-pages

cd -

