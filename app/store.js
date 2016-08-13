import { createStore, applyMiddleware } from 'redux';
import reducer from './reducers';
import createSagaMiddleware from 'redux-saga';

const sagaMiddleware = createSagaMiddleware();

export default {
  store: createStore(reducer, applyMiddleware(sagaMiddleware)),
  sagaMiddleware
}
