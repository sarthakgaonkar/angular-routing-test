# FROM public.ecr.aws/docker/library/node:latest as build
FROM mirror.gcr.io/library/node:18 AS build

# Build argument (base64 JSON from Cloud Build)
# ARG JSON_B64

# # Decode JSON and show it
# RUN echo "==== DECODING JSON PARAMETER ====" \
#     && echo "$JSON_B64" | base64 -d > /app/config.json \
#     && cat /app/config.json

WORKDIR /app

COPY package*.json /app
RUN npm install --force
COPY . /app
RUN npm run build


# Stage 2 — Nginx
# FROM public.ecr.aws/nginx/nginx:latest
FROM mirror.gcr.io/library/nginx:latest

# Copy JSON again if needed (optional)
# ARG JSON_B64
# RUN echo "$JSON_B64" | base64 -d > /config.json \
#     && echo "==== JSON AVAILABLE IN FINAL IMAGE: ====" \
#     && cat /config.json

COPY --from=build /app/dist/angular-proj-1/* /usr/share/nginx/html/

RUN ls /usr/share/nginx/html/
