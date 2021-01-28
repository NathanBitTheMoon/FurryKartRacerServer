port = 6621;

socket = network_create_server(network_socket_tcp, port, 12);

socket_list = ds_list_create();
username_map = ds_map_create();
username_list = ds_list_create();