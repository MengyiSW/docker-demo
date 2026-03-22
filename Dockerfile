FROM nginx:alpine

# copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static site into nginx's default serve path
COPY html/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# nginx runs by default; no CMD needed
CMD echo "" \
 && echo "========================================" \
 && echo "😎 Hey SimWellers!" \
 && echo "🚀 Docker Demo Container Started" \
 && echo "" \
 && echo "Open your browser:" \
 && echo "👉 http://localhost:8080" \
 && echo "" \
 && echo "Enjoy the demo!" \
 && echo "========================================" \
 && nginx -g 'daemon off;'