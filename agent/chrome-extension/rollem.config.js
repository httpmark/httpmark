import { sync as glob } from 'glob';
import { map, compose } from 'ramda';
import babel from 'rollup-plugin-babel';
import commonjs from "rollup-plugin-commonjs"
import nodeResolve from 'rollup-plugin-node-resolve'
import uglify from 'rollup-plugin-uglify';

const files = 'src/**/index.js';

const configureBundle = entry => ({
  entry,
  dest: `build/${entry.split('/')[1]}.js`,
  format: 'iife',
  plugins: [ babel(), nodeResolve(), commonjs() ]
})

export default compose(map(configureBundle), glob)(files)
