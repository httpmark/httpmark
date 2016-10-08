import { sync as glob } from 'glob';
import babel from 'rollup-plugin-babel';
import uglify from 'rollup-plugin-uglify';

export default glob('src/**/index.js').map(entry => {
  const [, name,] = entry.split('/');
  return {
    entry,
    dest: `bundles/${name}.js`,
    format: 'cjs',
    plugins: [ babel(), uglify() ]
  }
});
