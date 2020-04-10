module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: './tsconfig.json',
  },
  plugins: ['@typescript-eslint'],
  extends: [
    'airbnb-typescript/base',
    'eslint:recommended',
    'plugin:@typescript-eslint/eslint-recommended',
    'plugin:@typescript-eslint/recommended',
    'prettier/@typescript-eslint',
  ],
  rules: {
    'sort-imports': 'warn',
    'max-len': ['error', 120],
    quotes: 'error',
    'linebreak-style': 'off', // TODO à réactiver et voir si pas mieux d'utiliser LF
    'no-plusplus': 'off',
    'prefer-default-export': 'off',
  },
};
