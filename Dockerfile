# Use lightweight web server
FROM nginx:latest

# Copy your app
COPY index.html /usr/share/nginx/html/index.html

# Expose port
EXPOSE 80
