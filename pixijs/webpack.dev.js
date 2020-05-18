const merge = require('webpack-merge');
const common = require('./webpack.common');

const devConfig = {
  devServer: {
    host: '0.0.0.0',
    port: 8080,
    disableHostCheck: true,
  },
  mode: 'development',
  devtool: 'inline-source-map',
};

module.exports = (env) => [
  merge(common(env)[0], devConfig),
  merge(common(env)[1], devConfig),
  merge(common(env)[2], devConfig),
];
