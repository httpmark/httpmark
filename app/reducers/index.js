import { combineReducers } from 'redux';

const agent = (state = false, action) => {
  switch (action.type) {
    case 'AGENT_LAUNCH_REQUEST_SENT':
      return 'Agent Launched!';
    case 'AGENT_LAUNCH_REQUEST_REGISTERED':
      return 'Agent Connected!';
    default:
      return state;
  }
};

export default combineReducers({
  agent,
});
