import { combineReducers } from 'redux';

const agent = (state = false, action) => {
  switch (action.type) {
    case 'AGENT_LAUNCHED':
      return true;
  }
  return state
}

export default combineReducers({
  agent
})
