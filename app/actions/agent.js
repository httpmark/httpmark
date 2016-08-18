export const agentLaunched = result => ({
  type: 'AGENT_LAUNCH_REQUEST_SENT', result,
});

export const agentRegistered = result => ({
  type: 'AGENT_LAUNCH_REQUEST_REGISTERED', result,
});

export const agentTestRunStarted = result => ({
  type: 'AGENT_TEST_RUN_STARTED', result,
});

export const agentTestRunFinished = result => ({
  type: 'AGENT_TEST_RUN_FINISHED', result,
});
