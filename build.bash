cd /home/yusuf/Documents/lebaladna_app/frontend # Use an absolute path (Use your own path) 
flutter clean
flutter pub upgrade --major-versions
flutter build web --web-renderer canvaskit --no-web-resources-cdn --release
cd build/web
zip web -r *
mv web.zip ../../../

