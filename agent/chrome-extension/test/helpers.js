import chai from 'chai';
import { spy } from 'sinon';
import sinonChai from 'sinon-chai';
chai.use(sinonChai);

global.expect = chai.expect;
global.spy = spy;

global.chrome = {
  runtime: {
    onConnect: {
      addListener() {}
    }
  },
  tabs: {
    update() {}
  }
}
