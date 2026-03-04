# --- Build stage ---
FROM node:20-alpine AS build
WORKDIR /app

# Build tools (harmless if not needed; required by some native deps)
RUN apk add --no-cache python3 make g++

# Install deps (deterministic if lockfile exists)
COPY package.json package-lock.json* ./
RUN if [ -f package-lock.json ]; then \
      npm ci --no-audit --no-fund ; \
    else \
      npm install --no-audit --no-fund ; \
    fi

# Build static files
COPY . .
RUN npm run build

# --- Runtime stage ---
FROM nginx:alpine
# Vite output; for CRA use /app/build below instead of /app/dist
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
# JSON form is recommended for proper signal handling
CMD ["nginx", "-g", "daemon off;"]
