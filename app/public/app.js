const client = new ApolloClient({
    uri: '/graphql', // Your GraphQL server endpoint
  });

  // Define your GraphQL query
  const FEED_QUERY = gql`
    query GetFeed($feedId: ID!) {
      feed(id: $feedId) {
        id
        nick
        avatar
        twts {
          content
          createdAt
        }
      }
    }
  `;

  const feedId = 'YOUR_FEED_ID'; // Replace with the actual feed ID

  client.query({
    query: FEED_QUERY,
    variables: { feedId },
  })
  .then(result => {
    const feed = result.data.feed;

    // Display feed information in the app div
    const appDiv = document.getElementById('app');
    appDiv.innerHTML = `
      <h1>${feed.nick}</h1>
      <img src="${feed.avatar}" alt="Feed Avatar">
      <ul>
        ${feed.twts.map(twt => `
          <li>
            <p>${twt.content}</p>
            <p>${twt.createdAt}</p>
          </li>
        `).join('')}
      </ul>
    `;
  })
  .catch(error => {
    console.error('Error fetching feed:', error);
  });
