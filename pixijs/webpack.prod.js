const merge = require('webpack-merge');
const common = require('./webpack.common');

const prodConfig = {
  mode: 'production',
};

module.exports = (env) => [
  merge(common(env)[0], prodConfig),
  merge(common(env)[1], prodConfig),
  merge(common(env)[2], prodConfig),
];
