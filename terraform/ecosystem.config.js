module.exports = {
  apps: [
    {
      name: 'sleepy-api', // Your project name
      cwd: '/home/ubuntu/sleepy-api', // Path to your project
      script: 'pnpm', // For this example we're using npm, could also be yarn
      args: 'start', // Script to start the Strapi server, `start` by default
      env: {
        NODE_ENV: 'production',
        DATABASE_HOST: 'host', // database Endpoint under 'Connectivity & Security' tab
        DATABASE_PORT: 'port',
        DATABASE_NAME: 'name', // DB name under 'Configuration' tab
        DATABASE_USERNAME: 'user', // default username
        DATABASE_PASSWORD: 'password',
        CF_ACCESS_KEY_ID: '',
        CF_ACCESS_SECRET: '',
        CF_ENDPOINT: '',
        CF_BUCKET: '',
        CF_PUBLIC_ACCESS_URL: ''
      },
    },
  ],
};
