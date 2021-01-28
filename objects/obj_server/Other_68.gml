type = ds_map_find_value(async_load, "type");

switch(type) {
	case network_type_connect:
		socket = ds_map_find_value(async_load, "socket");
		ds_list_add(socket_list, socket);
		
		//obj_log.log("Socket connected");
		show_debug_message("Socket connected");
		
		break;
	
	case network_type_disconnect:
		socket = ds_map_find_value(async_load, "socket");
		ds_list_delete(socket_list, ds_list_find_index(socket_list, socket));
		
		//obj_log.log("Socket disconnected");
		show_debug_message("Socket disconnected");
		break;
	
	case network_type_data:
		socket = ds_map_find_value(async_load, "id");
		buffer = ds_map_find_value(async_load, "buffer");
		ds_list_add(obj_log.log_list, "[" + ds_map_find_value(async_load, "ip") + "] Address connected");
		pkt_receieve(socket, buffer, ds_map_find_value(async_load, "ip"));
		
		break;
}