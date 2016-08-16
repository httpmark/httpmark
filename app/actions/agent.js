export const agentLaunched = (type, result) => ({
  type: 'AGENT_LAUNCH_REQUEST_SENT', result,
});

export const agentRegistered = (type, result) => ({
  type: 'AGENT_LAUNCH_REQUEST_REGISTERED', result,
});
