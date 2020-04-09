const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

module.exports = {
    mode: 'development',
    entry: {
        examples: './src/examples/examples.ts',
        container: './src/examples/examples/demos-basic/container.ts',
        transparent: './src/examples/examples/demos-basic/transparent-background.ts',
        tinting: './src/examples/examples/demos-basic/tinting.ts',
    },
    devtool: 'inline-source-map',
    devServer: {
        contentBase: './dist',
    },
    plugins: [
        new CleanWebpackPlugin(),
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
                use: [
                    'style-loader',
                    'css-loader',
                ],
            },
            {
                test: /\.(png|svg|jpg|gif)$/,
                use: [
                    'file-loader',
                ],
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