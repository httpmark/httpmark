import fetch from 'isomorphic-fetch';

// eslint-disable-next-line import/prefer-default-export, consistent-return
export const callAgent = async url => {
  try {
    const response = await fetch('http://localhost:3000/spawn-agent', {
      method: 'post',
      body: JSON.stringify({
        url,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    });
    return await response.json();
  } catch (e) {
    // eslint-disable-line no-empty
  }
};
