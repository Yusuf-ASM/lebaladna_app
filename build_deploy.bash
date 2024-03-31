# Use an absolute path (Use your own path) 
# Frontend build + deployment:
cd /home/yusuf/Documents/lebaladna_app/frontend
flutter clean
flutter pub upgrade --major-versions
flutter build web --web-renderer canvaskit --release
cd build/web
scp -i /home/yusuf/Desktop/Server/sshKeys/backend -r * ubuntu@204.216.221.89:/home/ubuntu/lebaladna/frontend 
ssh  ubuntu@204.216.221.89 -i /home/yusuf/Desktop/Server/sshKeys/backend "cd /home/ubuntu/lebaladna/frontend; sudo cp -r * /usr/share/nginx/lebaladna/; sudo systemctl restart nginx"

# Local deployment:
# sudo rm -r /usr/share/nginx/test/*
# sudo cp -r * /usr/share/nginx/test/
# zip web -r *
# mv web.zip ../../../

# Backend build + deployment:
cd /home/yusuf/Documents/lebaladna_app/backend
npx tsc
scp -i /home/yusuf/Desktop/Server/sshKeys/backend -r .env package-lock.json package.json ./build/ ubuntu@204.216.221.89:/home/ubuntu/lebaladna/backend 
ssh  ubuntu@204.216.221.89 -i /home/yusuf/Desktop/Server/sshKeys/backend "cd /home/ubuntu/lebaladna/backend; source ~/.nvm/nvm.sh; npm i; pm2 restart lebaladna"
