# Use an official Node runtime as a parent image
FROM node:14 AS builder

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Use 'serve' to serve the built app
FROM node:14-alpine

# Set the working directory
WORKDIR /usr/src/app

# Install 'serve'
RUN npm install -g serve

# Copy the built app from the builder stage to the working directory
COPY --from=builder /usr/src/app/dist .

# Expose port 5000 (you can adjust this if needed)
EXPOSE 5000

# Start 'serve' when the container starts
CMD ["serve", "-p", "5000", "-s", "."]