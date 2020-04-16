const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: {
    home: './src/home.ts',
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
    click: './src/examples/examples/interaction/click.ts',
    hitarea: './src/examples/examples/interaction/hitarea.ts',
    masks_graphics: './src/examples/examples/masks/graphics.ts',
    masks_sprite: './src/examples/examples/masks/sprite.ts',
    masks_filter: './src/examples/examples/masks/filter.ts',
    dragon: './src/examples/examples/spine/dragon.ts',
    spineboy_pro: './src/examples/examples/spine/spineboy_pro.ts',
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
      {
        from: 'src/**/*.atlas',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(4, targetPath.length);
        },
      },
    ]),
    new HtmlWebpackPlugin({
      title: 'TypeScript & PixiJS',
      template: './src/home.html',
      chunks: ['home'],
    }),
    new HtmlWebpackPlugin({
      filename: 'examples.html',
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
    new HtmlWebpackPlugin({
      filename: 'click.html',
      title: 'PixiJS - Click',
      chunks: ['click'],
    }),
    new HtmlWebpackPlugin({
      filename: 'hitarea.html',
      title: 'PixiJS - Hitarea',
      chunks: ['hitarea'],
    }),
    new HtmlWebpackPlugin({
      filename: 'masks_graphics.html',
      title: 'PixiJS - Masks Graphics',
      chunks: ['masks_graphics'],
    }),
    new HtmlWebpackPlugin({
      filename: 'masks_sprite.html',
      title: 'PixiJS - Masks Sprite',
      chunks: ['masks_sprite'],
    }),
    new HtmlWebpackPlugin({
      filename: 'masks_filter.html',
      title: 'PixiJS - Masks Filter',
      chunks: ['masks_filter'],
    }),
    new HtmlWebpackPlugin({
      filename: 'dragon.html',
      title: 'PixiJS - Dragon',
      chunks: ['dragon'],
    }),
    new HtmlWebpackPlugin({
      filename: 'spineboy_pro.html',
      title: 'PixiJS - Spineboy Pro',
      chunks: ['spineboy_pro'],
    }),
    new HtmlWebpackPlugin({
      filename: 'benchmarks.html',
      title: 'PixiJS - Spineboy Pro',
      template: './src/benchmarks/benchmark.html',
      chunks: [''],
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
