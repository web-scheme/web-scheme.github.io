const { defaultTheme } = require('@vuepress/theme-default')

module.exports = {
  title: 'WebScheme',
  description: 'R⁷RS Scheme for WebAssembly',

  theme: defaultTheme({
    logo: '/logo.svg',
    repo: 'https://github.com/Web-Scheme/s-lang',
    repoLabel: 'Git',
    docsDir: 'docs',
    contributors: false,
    editLink: false,
    lastUpdated: false,
    sidebar: [
      'intro.md',
      {
        text: 'Design',
        link: '/core-modules',
        children: [
          'core-modules.md',
          'component-model.md',
        ],
      },
    ],
  }),

  plugins: [
    {
      name: 'clean-urls',
      extendsPage: (page) => {
        if (!page.frontmatter?.permalink) {
          const { path } = page;
          if (path.endsWith('.html')) {
            page.path = path.slice(0, -5);
          } else if (path.endsWith('/')) {
            page.path = path.slice(0, -1);
          }
        }
      },
    },
  ],
}
