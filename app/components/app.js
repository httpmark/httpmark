import React, { Component } from 'react';

export default class extends Component {
  render() {
    return (
      <div>
        <header>This is the header!</header>
        <main>
          {this.props.children}
        </main>
      </div>
    );
  }
}
