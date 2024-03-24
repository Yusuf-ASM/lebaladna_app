cd /home/yusuf/Documents/lebaladna_app/frontend
flutter clean
flutter pub upgrade --major-versions
flutter build web --web-renderer canvaskit --no-web-resources-cdn --release
cd build/web
sudo rm -r /usr/share/nginx/test/*
sudo cp -r * /usr/share/nginx/test/
zip web -r *
mv web.zip ../../../

