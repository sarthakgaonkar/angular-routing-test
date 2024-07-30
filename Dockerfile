FROM public.ecr.aws/docker/library/node:latest as build

# Set the working directory
WORKDIR /app

# Add the source code to app
COPY package*.json /app

# Install all the dependencies
RUN npm install --force

COPY . /app

# Generate the build of the application
RUN npm run build 


# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM public.ecr.aws/nginx/nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=build /app/dist/angular-proj-1/* /usr/share/nginx/html/

RUN ls /usr/share/nginx/html/
