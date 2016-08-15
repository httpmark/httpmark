import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { agentLaunched } from '../actions/agent';

class Homepage extends Component {
  render() {
    return (
      <div>
        <button onClick={this.props.agentLaunched}>Launch agen</button>
        {this.props.agent}
      </div>
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
