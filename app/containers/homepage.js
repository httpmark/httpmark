import React, { Component } from 'react';
import { last } from 'lodash/fp';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { agentLaunched } from '../actions/agent';

const submitTest = e => {
  return this.props.agentLaunched(e);
}

class Homepage extends Component {
  onSubmit(e) {
    e.preventDefault();
    this.props.agentLaunched(e.target.elements[0].value);
  }

  render() {
    return (
      <div>
        <form onSubmit={::this.onSubmit}>
          <input type="url" />
          <button type="submit">Run test</button>
        </form>
        <table>
          <thead>
            <tr>
              <th>URL under test</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            {
              this.props.tests.map(test => (
                <tr>
                  <td>{test.url}</td>
                  <td>{last(test.status)}</td>
                </tr>
              ))
            }
          </tbody>
        </table>
      </div>
    );
  }
}

const mapDispatchToProps = dispatch => ({
  agentLaunched(url) {
    return dispatch(agentLaunched(url));
  },
});

const mapStateToProps = state => ({
  tests: state.tests,
});

export default connect(mapStateToProps, mapDispatchToProps)(Homepage);
