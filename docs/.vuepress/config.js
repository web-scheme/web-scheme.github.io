const { defaultTheme } = require('@vuepress/theme-default');
const markdownItFootnote = require('markdown-it-footnote');

module.exports = {
  title: 'WebScheme',
  description: 'R⁷RS Scheme for WebAssembly',
  head: [
    ['script', {
       defer: true,  // TODO: See if there's a better syntax for boolean attributes.
       src: 'https://static.cloudflareinsights.com/beacon.min.js',
       'data-cf-beacon': '{\\"token\\": \\"10e50002c4164673b356d1be97900968\\"}',
    }],
  ],

  theme: defaultTheme({
    logo: '/logo.svg',
    repo: 'https://github.com/web-scheme/s-lang',
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

  markdown: {
    links: {
      externalAttrs: {
        target: '_self',             // Open links in the current tab by default.
        rel: 'noopener noreferrer',  // Guard against XSS.
      },
    },
  },

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
    {
      name: 'markdown-footnotes',
      extendsMarkdown: (md) => {
        md.use(markdownItFootnote);
      },
    },
  ],
}
