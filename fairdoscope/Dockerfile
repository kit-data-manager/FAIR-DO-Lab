FROM busybox:latest
# image inspired by https://lipanski.com/posts/smallest-docker-image-static-website

# Create a non-root user to own the files and run our server
RUN adduser -D static
USER static
WORKDIR /home/static

# usage of wget in busybox (from https://linux.die.net/man/1/busybox)
# -O = output file
RUN wget "https://github.com/kit-data-manager/fairdoscope/archive/refs/heads/master.zip" \
    -O /tmp/fairdoscope.zip \
    && unzip /tmp/fairdoscope.zip -d . \
    && mv fairdoscope-master/* ./ \
    && rm -rf /tmp/fairdoscope.zip ./fairdoscope-master

# usage of httpd (from https://linux.die.net/man/1/busybox)
# -f = forground (do not detach)
# -v = verbose
# -p = [IP:]PORT
CMD ["busybox", "httpd", "-f", "-v", "-p", "80"]