#ifndef GOPHER_CLIENT_H
#define GOPHER_CLIENT_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <unistd.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Sends a Gopher request to the specified server and retrieves the response.
 *
 * @param server The hostname or IP address of the Gopher server.
 * @param port The port number to connect to on the server.
 * @param path The path on the Gopher server to request.
 * @param query The query to include in the request (optional).
 * @return A pointer to the response string if successful, NULL otherwise.
 *         Remember to free the memory after use.
 */
char* send_gopher_request(const char* server, int port, const char* path, const char* query);

#ifdef __cplusplus
}
#endif

#endif // GOPHER_CLIENT_H
