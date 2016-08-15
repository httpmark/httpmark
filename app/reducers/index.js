import { combineReducers } from 'redux';

const agent = (state = false, action) => {
  switch (action.type) {
    case 'AGENT_LAUNCHED':
      return 'Agent Launched!';
    case 'AGENT_CONNECTED':
      return 'Agent Connected!';
    default:
      return state;
  }
};

export default combineReducers({
  agent,
});
