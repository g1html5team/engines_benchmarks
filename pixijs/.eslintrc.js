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
    'max-len': ['error', 120],
    quotes: 'error',
    'linebreak-style': 'off', // TODO à réactiver et voir si pas mieux d'utiliser LF
    'no-plusplus': 'off',
    'prefer-default-export': 'off',
    'lines-between-class-members': 'off',
    'import/prefer-default-export': 'off',
    '@typescript-eslint/explicit-member-accessibility': 'error',
    'no-param-reassign': ['error', { props: false }],
    'no-await-in-loop': 'off',
    'operator-linebreak': 'off',
  },
};
