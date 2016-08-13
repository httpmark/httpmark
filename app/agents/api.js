import fetch from 'isomorphic-fetch';

export const callAgent = async () => {
  try {
    const response = await fetch('http://localhost:3000/spawn-agent', {
      method: 'post'
    });
    return await response.json();
  } catch (e) {

  }
};
