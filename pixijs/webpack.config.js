const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: {
    examples: './src/examples/examples.ts',
    container: './src/examples/examples/demos_basic/container.ts',
    transparent: './src/examples/examples/demos_basic/transparent_background.ts',
    tinting: './src/examples/examples/demos_basic/tinting.ts',
    cache: './src/examples/examples/demos_basic/cache_as_bitmap.ts',
    particle: './src/examples/examples/demos_basic/particle_container.ts',
    blend: './src/examples/examples/demos_basic/blend_mode.ts',
    simple_plane: './src/examples/examples/demos_basic/simple_plane.ts',
  },
  devtool: 'inline-source-map',
  devServer: {
    contentBase: './dist',
  },
  plugins: [
    new CleanWebpackPlugin(),
    new CopyPlugin([
      {
        from: 'src/**/*.json',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(4, targetPath.length);
        },
      },
      {
        from: 'src/**/*.png',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(4, targetPath.length);
        },
      },
      {
        from: 'src/**/*.png',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(4, targetPath.length);
        },
      },
    ]),
    new HtmlWebpackPlugin({
      title: 'PixiJS - Examples',
      template: './src/examples/examples.html',
      chunks: ['examples'],
    }),
    new HtmlWebpackPlugin({
      filename: 'container.html',
      title: 'PixiJS - Container',
      chunks: ['container'],
    }),
    new HtmlWebpackPlugin({
      filename: 'transparent.html',
      title: 'PixiJS - Tranparent background',
      chunks: ['transparent'],
    }),
    new HtmlWebpackPlugin({
      filename: 'tinting.html',
      title: 'PixiJS - Tinting',
      chunks: ['tinting'],
    }),
    new HtmlWebpackPlugin({
      filename: 'cache.html',
      title: 'PixiJS - CacheAsBitmap',
      chunks: ['cache'],
    }),
    new HtmlWebpackPlugin({
      filename: 'particle.html',
      title: 'PixiJS - Particle Container',
      chunks: ['particle'],
    }),
    new HtmlWebpackPlugin({
      filename: 'blend.html',
      title: 'PixiJS - Blend Mode',
      chunks: ['blend'],
    }),
    new HtmlWebpackPlugin({
      filename: 'simple-plane.html',
      title: 'PixiJS - Simple Plane',
      chunks: ['simple_plane'],
    }),
  ],
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader'],
      },
      {
        test: /\.(png|svg|jpg|gif)$/,
        use: ['file-loader'],
      },
    ],
  },
  resolve: {
    extensions: ['.ts', '.js'],
  },
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
};
