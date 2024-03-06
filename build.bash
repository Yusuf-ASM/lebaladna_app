cd /home/yusuf/Documents/lebaladna_app/frontend
flutter clean
flutter pub upgrade --major-versions
flutter build web --web-renderer canvaskit --release
cd build/web
zip web -r *
mv web.zip ../../../

