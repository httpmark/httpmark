import { takeEvery } from 'redux-saga';
import { put } from 'redux-saga/effects';

function* spawnAgent() {
  try {
    // const user = yield call(callAgent);
    yield put({ type: 'AGENT_CONNECTED' });
  } catch (e) {
    yield put({ type: 'AGENT_NOT_SPAWNED' });
  }
}

export default function* () {
  yield* takeEvery('AGENT_LAUNCHED', spawnAgent);
}
