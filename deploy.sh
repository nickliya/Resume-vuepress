set -e
npm run build
cd resume/.vuepress/dist

git init
git add -A
git commit -m 'deploy'

git push -f https://github.com/Siricee/Resume-vuepress.git master:gh-pages

cd -

