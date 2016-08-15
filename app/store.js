import { createStore, applyMiddleware } from 'redux';
import createSagaMiddleware from 'redux-saga';
import reducer from './reducers';

const sagaMiddleware = createSagaMiddleware();

export default {
  store: createStore(reducer, applyMiddleware(sagaMiddleware)),
  sagaMiddleware,
};
