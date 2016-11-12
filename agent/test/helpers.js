import chai from 'chai';
import { spy } from 'sinon';
import sinonChai from 'sinon-chai';

chai.use(sinonChai);

global.spy = spy;
global.expect = chai.expect;
