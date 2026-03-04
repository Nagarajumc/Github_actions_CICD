# --- Build Stage ---
FROM node:20-alpine AS build
WORKDIR /app

# Needed for node-gyp (safe even if unused)
RUN apk add --no-cache python3 make g++

COPY package.json package-lock.json* ./

RUN if [ -f package-lock.json ]; then \
      npm ci --no-audit --no-fund ; \
    else \
      npm install --no-audit --no-fund ; \
    fi

COPY . .
RUN npm run build

# --- Run Stage ---
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
