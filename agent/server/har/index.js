export default class {
  constructor(asset) {
    this.assets = [];
    this.timings = {};
  }
  getBlob() {
    return {
      log: {
        creator: {
          name: 'WebAppTest',
          version: '0.1'
        },
        pages : {
          id: '0',
          pageTimings: this.timings
        },
        assets: this.assets
      }
    }
  };

  addAsset(asset) {
    this.assets = [...this.assets, asset];
    return this.getBlob();
  };

  addTiming({ event, timing }) {
    this.timings = {...this.timings, [event]: timing};
    return this.getBlob();
  }
}
