#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <netdb.h>
#define MAX_RESPONSE_SIZE 4096

char* gopher_uri_to_req(const char* host, int port, const char* path, const char* query)
{ char* req = malloc(strlen(path) + strlen(query) + 4);  // +4 for "\t" and "\r\n"
  if (req == NULL) { return NULL;  /* Handle memory allocation failure */ }
  strcpy(req, path);
  if (strlen(query) > 0)
    { strcat(req, "\t");
      strcat(req, query); }
  strcat(req, "\r\n");
  return req; }

int open_socket(const char* host, int port)
{ struct sockaddr_in serv_addr;
  int sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if (sockfd < 0)
  { perror("Error opening socket");
  return NULL; }
  struct hostent* server_info = gethostbyname(host);
  if (server_info == NULL)
  { perror("Error getting server information");
    return NULL; }

    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(port);
    memcpy(&serv_addr.sin_addr.s_addr, server_info->h_addr, server_info->h_length);

    if (connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
    { perror("Error connecting to server");
      return NULL; }
    return sockfd; }

void nav_to_url(int socket, const char* req) {
    write(socket, req, strlen(req)); }

char* read_response(int socket)
{ char* response = malloc(MAX_RESPONSE_SIZE);
  if (response == NULL) { return NULL;  /* Handle memory allocation failure */ }
  ssize_t total_bytes_read = 0;
  ssize_t bytes_read;
  while (total_bytes_read < MAX_RESPONSE_SIZE - 1) {
    bytes_read = read(socket, response + total_bytes_read, MAX_RESPONSE_SIZE - 1 - total_bytes_read);
    if (bytes_read <= 0) {
        break;  /* Handle read errors or EOF */ }
    total_bytes_read += bytes_read; }
  response[total_bytes_read] = '\0';  // Null-terminate the response
  return response; }

char* send_gopher_request(const char* host, int port, const char* path, const char* query)
{ int socket = open_socket(host, port);
  if (socket == -1) { return NULL;  /* Handle socket open failure */ }

  char* req = gopher_uri_to_req(host, port, path, query);
  if (req == NULL) { close(socket);
    return NULL;  /* Handle memory allocation failure */ }

  nav_to_url(socket, req);
  free(req);

  char* response = read_response(socket);
  close(socket);
  return response; }
