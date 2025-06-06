module.exports = {
  apps: [
    {
      name: "frontend",
      cwd: "./frontend",
      script: "npm",
      args: "start",
    },
    {
      name: "whatsapp",
      cwd: "./whatsapp-message-sender",
      script: "npm",
      args: "start",
    },
  ],
};
