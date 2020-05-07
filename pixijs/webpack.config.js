const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');

const commonConfig = {
  mode: 'development',
  devtool: 'inline-source-map',
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
};

const homeConfig = Object.assign({}, commonConfig, {
  name: 'home',
  entry: {
    home: './src/home.ts',
  },
  devServer: {
    contentBase: './dist',
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: 'TypeScript & PixiJS',
      template: './src/home.html',
      chunks: ['home'],
    }),
  ],
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
});

const examplesConfig = Object.assign({}, commonConfig, {
  name: 'examples',
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
    click: './src/examples/examples/interaction/click.ts',
    hitarea: './src/examples/examples/interaction/hitarea.ts',
    masks_graphics: './src/examples/examples/masks/graphics.ts',
    masks_sprite: './src/examples/examples/masks/sprite.ts',
    masks_filter: './src/examples/examples/masks/filter.ts',
    dragon: './src/examples/examples/spine/dragon.ts',
    spineboy_pro: './src/examples/examples/spine/spineboy_pro.ts',
  },
  devServer: {
    contentBase: './dist',
  },
  plugins: [
    new CopyPlugin([
      {
        from: 'src/examples/**/*.json',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(13, targetPath.length);
        },
      },
      {
        from: 'src/examples/**/*.png',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(13, targetPath.length);
        },
      },
      {
        from: 'src/examples/**/*.png',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(13, targetPath.length);
        },
      },
      {
        from: 'src/examples/**/*.xml',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(13, targetPath.length);
        },
      },
      {
        from: 'src/examples/**/*.atlas',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(13, targetPath.length);
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
  ],
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist/examples'),
  },
});

const benchmarksConfig = Object.assign({}, commonConfig, {
  name: 'benchmarks',
  entry: {
    benchmarks: './src/benchmarks/benchmarks.ts',
    'run/add_remove_child': './src/benchmarks/run/add_remove_child.ts',
    'run/filters': './src/benchmarks/run/filters.ts',
    'run/blend_mode': './src/benchmarks/run/blend_mode.ts',
    'run/gpu_slots': './src/benchmarks/run/gpu_slots.ts',
    'run/atlas': './src/benchmarks/run/atlas.ts',
  },
  devServer: {
    contentBase: './dist/benchmarks',
  },
  plugins: [
    new CopyPlugin([
      {
        from: 'src/benchmarks/**/*.json',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(15, targetPath.length);
        },
      },
      {
        from: 'src/benchmarks/**/*.png',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(15, targetPath.length);
        },
      },
      {
        from: 'src/benchmarks/**/*.png',
        to: './',
        transformPath(targetPath) {
          return targetPath.substring(15, targetPath.length);
        },
      },
    ]),
    new HtmlWebpackPlugin({
      title: 'PixiJS - Benchmarks',
      template: './src/benchmarks/benchmarks.html',
      chunks: ['benchmarks'],
    }),
    new HtmlWebpackPlugin({
      filename: 'run/add_remove_child.html',
      title: 'Benchmark - Add remove child',
      chunks: ['run/add_remove_child'],
    }),
    new HtmlWebpackPlugin({
      filename: 'run/filters.html',
      title: 'Benchmark - Filters',
      chunks: ['run/filters'],
    }),
    new HtmlWebpackPlugin({
      filename: 'run/blend_mode.html',
      title: 'Benchmark - Blend mode',
      chunks: ['run/blend_mode'],
    }),
    new HtmlWebpackPlugin({
      filename: 'run/gpu_slots.html',
      title: 'Benchmark - GPU slots',
      chunks: ['run/gpu_slots'],
    }),
    new HtmlWebpackPlugin({
      filename: 'run/atlasses.html',
      title: 'Benchmark - Atlas',
      chunks: ['run/atlas'],
    }),
  ],
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist/benchmarks'),
  },
});

module.exports = [homeConfig, examplesConfig, benchmarksConfig];
