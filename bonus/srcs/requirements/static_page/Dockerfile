FROM debian:buster

# Install nginx
RUN apt update && apt install -y nginx

# Create the static_page directory in the container
RUN mkdir -p /static_page/html

# Set working directory
WORKDIR /static_page

# Copy the static files and nginx configuration
COPY ./html /static_page/html
COPY ./conf/nginx.conf /etc/nginx/

# Expose port 80 to be accessible outside the container
EXPOSE 80

# Command to run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]