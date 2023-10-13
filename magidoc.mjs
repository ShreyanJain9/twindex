export default {
    introspection: {
      /**
       * The SDL introspection type.
       */
      type: 'sdl',

      /**
       * A mandatory paths array where the schema files can be found.
       * Glob syntax is supported in case your schema is split into multiple files.
       */
      paths: ['schema.graphql'],
    },
    website: {
        /**
         * Either the name of the template to use for the website or,
         * if you used `magidoc eject` to create a starter, the path to your starter's directory.
         */
        template: 'carbon-multi-page',

        /**
         * Options to use for the website.
         * Some templates may not support all options.
         * Make sure you check the documentation of the chosen template.
         */
        options: {
          /**
           * Your application title.
           *
           * @default 'Magidoc'
           */
          appTitle: 'Twindex Docs',

          /**
           * Your application logo, which can either be
           * an absolute URL or a relative URL pointing to a static asset.
           * If your `siteRoot` is set and you use a relative URL, include the `siteRoot` in the path
           *
           * @default (magidoc logo)
           */
          appLogo: 'https://twtxt.readthedocs.io/en/latest/_static/twtxt.svg',

          /**
           * The directives that should appear in the documentation.
           * When using SDL introspection, the location and definition of these directives will be displayed where they are used.
           *
           * @default []
           */
          directives: [
            {
              name: "ValidDate",
              args: ["before", "after"],
            },
                    {
              name: "ValidInt",
              args: ["*"], // To document all args of a directive.
            },
            {
              name: "*", // To document all directives and all args.
              args: ["*"],
            },
          ],

          /**
           * Customize pages and their content. Each of these pages will be presented before the graphQL documentation.
           * Use this to present your API urls, authentication flows, designs, concepts, or whatever you want.
           *
           * @default (A default Magidoc page)
           */
          pages: [
            {
              /**
               * Each page must have a title for the navbar.
               */
              title: 'Welcome to Twindex',

              /**
               * The content. Markdown is supported, but be careful with the indentation.
               * Javascript multi-line templates conserve the indentation you have in your strings, which will not output properly.
               * It is recommended to either get your markdown from files or use a library to un-indent your strings.
               *
               * @see: https://www.npmjs.com/package/dedent
               */
              content: `
                # Twindex GraphQL API

                Read these docs to understand how the Twindex GraphQL API works. You can use this to access
                the API, or to explore the GraphQL schema. This is in order to browse the indexed network
                of Twtxt related stuff - tweets, feeds, mentions, etc.

                I will later add some explanations of use cases.
              `,
            },
          ],

          /**
           * A list of external links to render inside the template that could point to other external resources.
           *
           * Use this for social links (youtube, linkedin, slack, discord, etc),
           * external repositories, articles, other documentation, etc.
           *
           * @see https://github.com/magidoc-org/magidoc/blob/main/docs/magidoc.mjs for an example.
           *
           */
          externalLinks: [
            {
              /**
               * A mandatory href.
               */
              href: 'https://github.com/shreyanjain9/twindex',

              /**
               * A mandatory display name.
               */
              label: 'Main repository',

              /**
               * An optional position for the link in the page. Choices are ['header', 'navigation']
               *
               * @default navigation
               */
              position: 'navigation',

              /**
               * An optional group for the link, so that links with the same groups are put in the same section.
               */
              group: 'Repositories',

              /**
               * An optional link kind. (i.e github, linkedin, slack, discord, youtube, etc.).This is used to determine the icon to display.
               */
              kind: 'Github',
            },
          ],
        },
      },

  }
