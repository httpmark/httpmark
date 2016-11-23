import HARBlob, { addAsset, addTiming } from './';

describe('Creating a HAR blob', () => {
  it('renders a complete HAR-formatted structure', () => {
    const har = HARBlob();
    const expected = {
      log: {
        creator: {
          name: 'httpmark',
          version: '0.1'
        },
        pages : {
          id: '0',
          pageTimings: {}
        },
        assets: []
      }
    };
    expect(har).to.deep.equal(expected);
  });

  describe('Adding assets', () => {
    it('Adds asset to a HAR blob without an existing asset', () => {
      const har = HARBlob();
      const result = addAsset('first')(har);
      const expected = {
        log: {
          creator: {
            name: 'httpmark',
            version: '0.1'
          },
          pages : {
            id: '0',
            pageTimings: {}
          },
          assets: ['first']
        }
      };
      expect(result).to.deep.equal(expected);
    });

    it('Adds asset to a HAR blob with an existing asset', () => {
      const one = HARBlob();
      const two = addAsset('first')(one);
      const three = addAsset('second')(two);
      const expected = {
        log: {
          creator: {
            name: 'httpmark',
            version: '0.1'
          },
          pages : {
            id: '0',
            pageTimings: {}
          },
          assets: ['first', 'second']
        }
      };
      expect(three).to.deep.equal(expected);
    });
  });

  describe('Adding page timings', () => {
    it('Adds a timing', () => {
      const har = HARBlob();
      const result = addTiming({ DOMContentReady: 920293 })(har);
      const expected = {
        log: {
          creator: {
            name: 'httpmark',
            version: '0.1'
          },
          pages : {
            id: '0',
            pageTimings: {
              DOMContentReady: 920293
            }
          },
          assets: []
        }
      };
      expect(result).to.deep.equal(expected);
    });
  });
});
