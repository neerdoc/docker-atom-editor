FROM alpine:latest

ENV ATOM_VERSION v1.35.1

# Add dependencies
RUN apk add nodejs \
    nodejs-npm \
    python \
    build-base \
    pkgconfig \
    libsecret


# Copy source files
WORKDIR /build
ADD src/$ATOM_VERSION.tar.gz /build/
RUN mv * atom
WORKDIR atom

# Add fixes
COPY fix/script/package.json script/
COPY fix/script/build script/

# Run the bootstrap
RUN script/bootstrap

# Run the build
RUN script/build



RUN adduser -D -h /home/atom atom

USER atom

CMD ["/usr/bin/atom","-f"]
