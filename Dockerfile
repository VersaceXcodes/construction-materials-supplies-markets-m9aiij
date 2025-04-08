# Use Node.js v18 as the base image
FROM node:18-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./
COPY vitereact/package*.json ./vitereact/
COPY backend/package*.json ./backend/

# Install dependencies
RUN npm install
RUN cd vitereact && npm install
RUN cd backend && npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN cd vitereact && npm run build

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]