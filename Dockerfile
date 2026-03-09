FROM nginx:alpine

# copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static site into nginx's default serve path
COPY html/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# nginx runs by default; no CMD needed

CMD echo "🚀 Hey you are one step closer!" \
 && echo "✅ The app has been successfully started." \
 && echo "🌐 Open your browser at: http://localhost:8080" \
 && nginx -g 'daemon off;'
