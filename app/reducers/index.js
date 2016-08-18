import { update } from 'lodash/fp';
import { combineReducers } from 'redux';

const agent = (state = [], { type, result }) => {
  switch (type) {
    case 'AGENT_LAUNCH_REQUEST_SENT':
      return state.concat([{
        url: result,
        status: ['requestSent'],
      }]);
    case 'AGENT_LAUNCH_REQUEST_REGISTERED':
      return update([state.length - 1, 'status'], n => n.concat(['requestRegistered']), state);
    case 'AGENT_TEST_RUN_STARTED':
      console.log('WAHEY!!!!');
      return update([state.length - 1, 'status'], n => n.concat(['agentConnected']), state);
    default:
      return state;
  }
};

export default combineReducers({
  tests: agent,
});
