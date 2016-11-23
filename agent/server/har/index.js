import { append, lensPath, merge, over } from 'ramda';

export default () => ({
  log: {
    creator: {
      name: 'WebAppTest',
      version: '0.1'
    },
    pages : {
      id: '0',
      pageTimings: {}
    },
    assets: []
  }
});

export const addAsset = asset => over(lensPath(['log', 'assets']), append(asset));
export const addTiming = timing => over(lensPath(['log', 'pages', 'pageTimings']), merge(timing));
