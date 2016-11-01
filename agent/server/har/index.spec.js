import HARBlob from './';

describe('Creating a HAR blob', () => {
  it('renders a complete HAR-formatted structure', () => {
    const har = new HARBlob();
    const expected = {
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
    };
    expect(har.getBlob()).to.deep.equal(expected);
  });

  describe('Adding assets', () => {
    it('Adds asset to a HAR blob without an existing asset', () => {
      const har = new HARBlob();
      const result = har.addAsset('first');
      const expected = {
        log: {
          creator: {
            name: 'WebAppTest',
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
      const har = new HARBlob();
      har.addAsset('first');
      const result = har.addAsset('second');
      const expected = {
        log: {
          creator: {
            name: 'WebAppTest',
            version: '0.1'
          },
          pages : {
            id: '0',
            pageTimings: {}
          },
          assets: ['first', 'second']
        }
      };
      expect(result).to.deep.equal(expected);
    });
  });

  describe('Adding page timings', () => {
    it('Adds a timing', () => {
      const har = new HARBlob();
      const result = har.addTiming({
        event: 'DOMContentReady',
        timing: 920293
      })
      const expected = {
        log: {
          creator: {
            name: 'WebAppTest',
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
      }
      expect(result).to.deep.equal(expected);
    });
  })
});
