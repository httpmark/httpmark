import React, { Component } from 'react';
import { connect } from 'react-redux';
import spawnAgent from '../actions/agent';

class Homepage extends Component {
  render() {
    return (
      <div>
        <button onClick={this.props.hello}>Launch agent</button>
        {this.props.agent && 'Agent launched!'}
      </div>
    );
  }
}

const mapDispatchToProps = dispatch => ({
  hello: () => {
    return dispatch(spawnAgent('works'))
  }
});

const mapStateToProps = state => ({
  agent: state.agent
})

export default connect(mapStateToProps, mapDispatchToProps)(Homepage);
