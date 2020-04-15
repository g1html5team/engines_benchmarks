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
    slots: './src/examples/examples/demos_advanced/slots.ts',
    scratchcard: './src/examples/examples/demos_advanced/scratchcard.ts',
    basic: './src/examples/examples/sprite/basic.ts',
    texture: './src/examples/examples/sprite/texture_swap.ts',
    animated: './src/examples/examples/sprite/animated_sprite.ts',
    text: './src/examples/examples/text/text.ts',
    bitmap_text: './src/examples/examples/text/bitmap_text.ts',
    simple_graphics: './src/examples/examples/graphics/simple.ts',
    advanced_graphics: './src/examples/examples/graphics/advanced.ts',
    dynamic_graphics: './src/examples/examples/graphics/dynamic.ts',
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
      {
        from: 'src/**/*.xml',
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
      filename: 'simple_plane.html',
      title: 'PixiJS - Simple Plane',
      chunks: ['simple_plane'],
    }),
    new HtmlWebpackPlugin({
      filename: 'slots.html',
      title: 'PixiJS - Slots',
      chunks: ['slots'],
    }),
    new HtmlWebpackPlugin({
      filename: 'scratchcard.html',
      title: 'PixiJS - Scratchcard',
      chunks: ['scratchcard'],
    }),
    new HtmlWebpackPlugin({
      filename: 'basic.html',
      title: 'PixiJS - Basic',
      chunks: ['basic'],
    }),
    new HtmlWebpackPlugin({
      filename: 'texture_swap.html',
      title: 'PixiJS - Texture Swap',
      chunks: ['texture'],
    }),
    new HtmlWebpackPlugin({
      filename: 'animated_sprite.html',
      title: 'PixiJS - Texture Swap',
      chunks: ['animated'],
    }),
    new HtmlWebpackPlugin({
      filename: 'text.html',
      title: 'PixiJS - Text',
      chunks: ['text'],
    }),
    new HtmlWebpackPlugin({
      filename: 'bitmap_text.html',
      title: 'PixiJS - Bitmap Text',
      chunks: ['bitmap_text'],
    }),
    new HtmlWebpackPlugin({
      filename: 'simple_graphics.html',
      title: 'PixiJS - Simple Graphics',
      chunks: ['simple_graphics'],
    }),
    new HtmlWebpackPlugin({
      filename: 'advanced_graphics.html',
      title: 'PixiJS - Advanced Graphics',
      chunks: ['advanced_graphics'],
    }),
    new HtmlWebpackPlugin({
      filename: 'dynamic_graphics.html',
      title: 'PixiJS - Dynamic Graphics',
      chunks: ['dynamic_graphics'],
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
