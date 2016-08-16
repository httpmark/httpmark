import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { agentLaunched } from '../actions/agent';

class Homepage extends Component {
  render() {
    return (
      <form onSubmit={this.props.agentLaunched}>
        <input type="url" />
        <button type="submit">Run test</button>
        {this.props.agent}
      </form>
    );
  }
}

const mapDispatchToProps = dispatch => bindActionCreators({
  agentLaunched,
}, dispatch);

const mapStateToProps = state => ({
  agent: state.agent,
});

export default connect(mapStateToProps, mapDispatchToProps)(Homepage);
