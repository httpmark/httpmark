import { fork } from 'redux-saga/effects';
import spawnAgentWatcher from './agent';

export default function* (){
  yield fork(spawnAgentWatcher);
}
